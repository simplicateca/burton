<?php
/**
 * SiteModule - Normalize Block Twig Extension
 *
 * Splice any fragment block types into the block array.
 *
 * Combines JSON configs from multiple reference fields
 * (theme, variant, layout, interspace) into a single settings object
 *
 */

namespace modules\sitemodule\twigextensions;

use Craft;
use craft\elements\MatrixBlock;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;

class NormalizeBlockTwig extends AbstractExtension
{

    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'normalizeBlocks', [$this, 'normalizeBlocks'] ),
        ];
    }


    // find any fragment blocks and splice them into the block array
    public function normalizeBlocks( $blockArray, $builder = 'content', $originalSettings )
    {
        $blocks = [];
        $entry  = null;
        $blockArray = $blockArray ?? [];
        foreach( $blockArray as $block ) {

            // if $block is just an ID, look it up
            $isJustID  = is_int($block);
            $block     = $isJustID ? MatrixBlock::find()->id($block)->one() ?? [] : $block;

            if( !$entry ) {
                $entry = $block->owner ?? null;
            }

            $blockType = $block->type->handle ?? $block->type ?? $block->blockType ?? null;
            $settings  = $this->mergeBlockSettings( $block );

            if( $blockType == 'fragment' )
            {
                foreach( $block->fragments->all() as $fragment )
                {
                    $fragBlocks = $fragment->bodyBuilder->all() ?? $fragment->sidebarBuilder->all() ?? null;

                    foreach( $fragBlocks as $fragBlock )
                    {
                        $fragSettings = $this->mergeBlockSettings( $fragBlock, $settings );
                        $blocks[] = $this->beforeRenderBlock([
                            'object'   => $fragBlock,
                            'entry'    => $entry,
                            'builder'  => $builder,
                            'settings' => array_merge( $originalSettings, $fragSettings )
                        ]);
                    }
                }
            } else {
                $blocks[] = $this->beforeRenderBlock([
                    'object'   => $block,
                    'entry'    => $entry,
                    'builder'  => $builder,
                    'settings' => array_merge( $originalSettings, (array) $settings )
                ]);
            }
        }


        // add settings for next/previous siblings to each block
        foreach( $blocks AS $key => $block )
        {
            if( $blocks[$key-1]['settings'] ?? null )
            {
                $blocks[$key]['prev'] = $blocks[$key-1]['settings'];
                $blocks[$key]['settings']['themePrev'] = $blocks[$key-1]['settings']['theme'] ?? null;
            }

            if( $blocks[$key+1]['settings'] ?? null )
            {
                $blocks[$key]['next'] = $blocks[$key+1]['settings'];
                $blocks[$key]['settings']['themeNext'] = $blocks[$key+1]['settings']['theme'] ?? null;
                $blocks[$key+1]['settings']['inheritTheme'] = ( $blocks[$key]['settings']['theme'] == $blocks[$key+1]['settings']['theme'] );
            }

            if( $blocks[$key]['settings']['theme'] == 'INHERIT' || ( $blocks[$key]['settings']['inheritTheme'] ?? null ) )
            {
                $blocks[$key]['settings']['theme'] = $blocks[$key-1]['settings']['theme'] ?? null;
            }
        }

        return $blocks;
    }


    private function beforeRenderBlock( array $block )
    {
        $block = array_merge( $block['object']->fieldValues ?? $block['object'] ?? [], $block );

        $block['settings'] = array_merge( $block['settings'], [
            'uuid'       => $block['object']->id ?? craft\helpers\StringHelper::UUID(),
            'builder'    => $block['builder']    ?? null,
            'entryID'    => $block['entry']->id  ?? null,
            'entryUrl'   => $block['entry']->url ?? null,
            'entryType'  => $block['entry']->type->handle    ?? null,
            'section'    => $block['entry']->section->handle ?? $block['settings']['section'] ?? null,
            'blockType'  => $block['object']->type->handle   ?? $block['object']->type ?? $block['object']['type'] ?? $block['settings']['blockType'] ?? null,
            'normalized' => true,
        ]);

        return $block;
    }

    private function getFieldSettings( $field = null )
    {
        $settings = [];

        if( $field ) {
            $settings = $field->settings ?? [];
            if( get_class( $field ) == 'simplicateca\referencefield\fields\ProtoSelectorData' ) {
                $settings = array_merge(
                    $field->proto('settings') ?? [],
                    $field->data() ?? [],
                    $settings
                );
            }
        }

        return array_filter( $settings );
    }



    private function mergeBlockSettings( $block, $parentSettings = null )
    {
        if( empty( $block ) ) {
            return [];
        }

        $props = [
            'theme'      => (string) $block->theme ?? '',
            'variant'    => (string) $block->variant ?? '',
            'layout'     => (string) $block->layout ?? '',
            'interspace' => (string) $block->interspace ?? ''
        ];

        $layout     = $this->getFieldSettings( $block->layout ?? null );
        $variant    = $this->getFieldSettings( $block->variant ?? null );
        $theme      = $this->getFieldSettings( $block->theme ?? null );
        $interspace = $this->getFieldSettings( $block->interspace ?? null );

        // if this is a content block that was inside a fragment container,
        // figure out where to grab background/interspace settings from
        if( $parentSettings )
        {
            if( $parentSettings['theme'] == 'FROMFRAGMENT' ) {
                unset( $parentSettings['theme'] );
            } else {
                $theme = [];
            }

            if( $parentSettings['interspace'] == 'FROMFRAGMENT' ) {
                unset( $parentSettings['interspace'] );
            } else {
                $interspace = [];
            }
        }

        // this occurs when a block is created by hand (or in the sitehub previewer),
        // rather than an actual Craft database element, and then run through normalizeBlocks()
        if( gettype($block) == 'array' ) {
            return array_merge( $block['settings'], $parentSettings ?? [] );
        }

        // this is for normal MatrixBlock elements
        return array_merge( ...array_filter([
            $layout,
            $variant,
            $theme,
            $interspace,
            $props,
            $parentSettings
        ]));
    }
}