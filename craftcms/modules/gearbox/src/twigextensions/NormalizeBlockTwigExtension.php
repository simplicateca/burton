<?php
/**
 * Gearbox - Normalize Block Twig Extension
 *
 * Splice any fragment block types into the block array.
 *
 * Combines JSON configs from multiple reference fields
 * (theme, variant, layout, interspace) into a single settings object
 *
 */

namespace modules\gearbox\twigextensions;

use Craft;
use craft\elements\MatrixBlock;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;

class NormalizeBlockTwigExtension extends AbstractExtension
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

            $blockType = $block->type->handle ?? $block->type ?? null;
            $settings  = $this->mergeBlockSettings( $block );

            if( $blockType == 'fragment' )
            {
                foreach( $block->fragments->all() as $fragment )
                {
                    $fragBlocks = $fragment->contentBuilder->all() ?? $fragment->sidebarBuilder->all() ?? null;

                    foreach( $fragBlocks as $fragBlock )
                    {
                        $fragSettings = $this->mergeBlockSettings( $fragBlock, $settings );
                        $blocks[] = $this->beforeRenderBlock([
                            'content'  => $fragBlock,
                            'entry'    => $entry,
                            'builder'  => $builder,
                            'settings' => array_merge( $originalSettings, $fragSettings )
                        ]);
                    }
                }
            } else {
                $blocks[] = $this->beforeRenderBlock([
                    'content'  => $block,
                    'entry'    => $entry,
                    'builder'  => $builder,
                    'settings' => array_merge( $originalSettings, $settings )
                ]);
            }
        }


        // add settings for next/previous siblings to each block
        foreach( $blocks AS $key => $block )
        {
            if( $blocks[$key-1]->settings ?? null )
            {
                $block->prev = $blocks[$key-1]->settings;
                $blocks[$key]->settings['themePrev'] = $blocks[$key-1]->settings['theme'] ?? null;
            }

            if( $blocks[$key+1]->settings ?? null )
            {
                $block->next = $blocks[$key+1]->settings;

                $blocks[$key]->settings['themeNext'] = $blocks[$key+1]->settings['theme'] ?? null;

                $blocks[$key+1]->settings['inheritTheme'] = ( $blocks[$key]->settings['theme'] == $blocks[$key+1]->settings['theme'] );
            }

            if( $blocks[$key]->settings['theme'] == 'INHERIT' || ( $blocks[$key]->settings['inheritTheme'] ?? null ) )
            {
                $blocks[$key]->settings['theme'] = $blocks[$key-1]->settings['theme'] ?? null;
            }
        }

        return $blocks;
    }


    private function beforeRenderBlock( array $block ) : BurtonMatrixBlock
    {
        return new BurtonMatrixBlock(
            $block['content'],
            array_merge( $block['settings'], [
                'uuid'       => $block['content']->id ?? craft\helpers\StringHelper::UUID(),
                'builder'    => $block['builder']    ?? null,
                'entryID'    => $block['entry']->id  ?? null,
                'entryUrl'   => $block['entry']->url ?? null,
                'entryType'  => $block['entry']->type->handle    ?? null,
                'section'    => $block['entry']->section->handle ?? null,
                'blockType'  => $block['content']->type->handle  ?? $block['content']->type ?? $block['content']['type'] ?? null,
                'normalized' => true,
            ] )
        );
    }


    private function mergeBlockSettings( $block, $parentSettings = null )
    {
        if( empty( $block ) ) {
            return [];
        }

        $layout     = ( $block->layout     ?? null ) ? $block->layout->reference()     ?? [] : [];
        $variant    = ( $block->variant    ?? null ) ? $block->variant->reference()    ?? [] : [];
        $theme      = ( $block->theme      ?? null ) ? $block->theme->reference()      ?? [] : [];
        $interspace = ( $block->interspace ?? null ) ? $block->interspace->reference() ?? [] : [];

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

        $settings = array_merge( ...array_filter([
            $layout['settings']     ?? null,
            $variant['settings']    ?? null,
            $theme['settings']      ?? null,
            $interspace['settings'] ?? null,
            [
                'theme'      => $theme['value']      ?? null,
                'variant'    => $variant['value']    ?? null,
                'layout'     => $layout['value']     ?? null,
                'interspace' => $interspace['value'] ?? null
            ],
            $parentSettings
        ]));

        return $settings;
    }
}


class BurtonMatrixBlock
{
    private $object;
    public  $settings = [];
    public  $prev     = [];
    public  $next     = [];

    public function __construct($object, $settings) {

        $this->object   = $object;
        $this->settings = $settings;
    }

    public function __call( $method, $arguments ) {
        return $this->object->$method ?? call_user_func_array([$this->object, $method], $arguments);
    }
}