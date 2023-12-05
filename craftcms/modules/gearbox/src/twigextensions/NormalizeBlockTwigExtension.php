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
        // if $entry is just an ID, look it up
        // $entry  = is_int($entry) ? Entry::find()->id($entry)->one() ?? [] : $entry;

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

            if( $blockType == 'fragment' ) {
                foreach( $block->fragments->all() as $fragment ) {
                    $fragmentType = $fragment->type->handle ?? null;
                    if( in_array( $fragmentType, ['contentFragment', 'sidebarFragment', 'headerFragment'] ) ) {
                        $fragBlocks = $fragment->contentBuilder->all() ?? $fragment->sidebarBuilder->all() ?? $fragment->headerBuilder->all();
                        foreach( $fragBlocks as $fragBlock ) {
                            $settings = $this->mergeBlockSettings( $fragBlock, $block );
                            $blocks[] = $this->beforeRenderBlock([
                                'content'  => $fragBlock,
                                'entry'    => $entry,
                                'builder'  => $builder,
                                'settings' => array_merge( $originalSettings, $settings )
                            ]);
                        }
                    } else {
                        $settings = $this->mergeBlockSettings( $fragment, $block );
                        $blocks[] = $this->beforeRenderBlock([
                            'content'  => $block,
                            'entry'    => $entry,
                            'fragment' => $fragment,
                            'builder'  => $builder,
                            'settings' => array_merge( $originalSettings, $settings)
                        ]);
                    }
                }
            } else {
                $settings = $this->mergeBlockSettings( $block );

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
            }

            if( $blocks[$key+1]->settings ?? null )
            {
                $block->next = $blocks[$key+1]->settings;

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
                'entryType'  => $block['entry']->type->handle ?? null,
                'section'    => $block['fragment']->section->handle  ?? $block['entry']->section->handle ?? null,
                'blockType'  => $block['content']->type->handle      ?? $block['content']->type ?? $block['content']['type'] ?? null,
                'variant'    => $block['content']->variant->value    ?? null,
                'theme'      => $block['content']->theme->value      ?? null,
                'interspace' => $block['content']->interspace->value ?? null,
                'layout'     => $block['content']->layout->value     ?? null,
            ] )
        );
    }


    private function mergeBlockSettings( $block, $fragmentParent = null )
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
        if( $fragmentParent )
        {
            // background
            if( $fragmentParent->theme && $fragmentParent->theme != 'FROMFRAGMENT' ) {
                $theme = $fragmentParent->theme->reference() ?? $theme;
            }

            // interspace
            if( $fragmentParent->interspace && $fragmentParent->interspace != 'FROMFRAGMENT' ) {
                $interspace = $fragmentParent->interspace->reference() ?? $interspace;
            }
        }

        $settings = array_merge(
            $layout['settings']     ?? [],
            $variant['settings']    ?? [],
            $theme['settings']      ?? [],
            $interspace['settings'] ?? []
        );

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