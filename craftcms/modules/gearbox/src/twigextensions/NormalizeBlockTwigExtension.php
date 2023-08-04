<?php
/**
 * Gearbox - Normalize Block Twig Extension
 *
 * Splice any fragment block types into the block array.
 *
 * Combines JSON configs from multiple reference fields
 * (bg, variant, layout, spacing) into a single settings object
 *
 */

namespace modules\gearbox\twigextensions;

use Craft;
use craft\elements\Entry;
use craft\elements\MatrixBlock;

use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;

class NormalizeBlockTwigExtension extends AbstractExtension
{

    public function getFunctions(): array
    {
        return [
            new TwigFunction('normalizeBlocks', [$this, 'normalizeBlocks']),
        ];
    }


    // find any fragment blocks and splice them into the block array
    public function normalizeBlocks( $blockArray, $entry = [], $builder = 'content' )
    {
        // if $entry is just an ID, look it up
        $entry  = is_int($entry) ? Entry::find()->id($entry)->one() ?? [] : $entry;

        $blocks = [];
        foreach( $blockArray as $block ) {

            // if $block is just an ID, look it up
            $isJustID  = is_int($block);
            $block     = $isJustID ? MatrixBlock::find()->id($block)->one() ?? [] : $block;

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
                                'settings' => $settings
                            ]);
                        }
                    } else {
                        $settings = $this->mergeBlockSettings( $fragment, $block );
                        $blocks[] = $this->beforeRenderBlock([
                            'content'  => $block,
                            'entry'    => $entry,
                            'fragment' => $fragment,
                            'builder'  => $builder,
                            'settings' => $settings
                        ]);
                    }
                }
            } else {
                $settings = $this->mergeBlockSettings( $block );

                $blocks[] = $this->beforeRenderBlock([
                    'content'  => $block,
                    'entry'    => $entry,
                    'builder'  => $builder,
                    'settings' => $settings
                ]);
            }
        }

        return $blocks;
    }


    private function beforeRenderBlock( array $block ) : array
    {
        $block['isNormal']      = true;
        $block['entryHandle']   = $block['entry']->type->handle ?? '';
        $block['sectionHandle'] = $block['fragment']->section->handle ?? $block['entry']->section->handle ?? '';
        $block['blockType']     = $block['content']->type->handle ?? $block['content']->type ?? $block['content']['type'] ?? '';

        $block['settings']['entryID']  = $block['entry']->id  ?? null;
        $block['settings']['entryUrl'] = $block['entry']->url ?? null;

        return $block;
    }


    private function mergeBlockSettings( $block, $fragmentParent = null ) {

        if( empty( $block ) ) {
            return [];
        }

        $layout    = $block->layout  ? $block->layout->reference()  ?? [] : [];
        $variant   = $block->variant ? $block->variant->reference() ?? [] : [];
        $bg        = $block->bg      ? $block->bg->reference()      ?? [] : [];
        $spacing   = $block->spacing ? $block->spacing->reference() ?? [] : [];

        // if this is a content block that was inside a fragment container,
        // figure out where to grab background/spacing settings from
        if( $fragmentParent )
        {
            // background
            if( $fragmentParent->bg && $fragmentParent->bg != 'FROMFRAGMENT' ) {
                $bg = $fragmentParent->bg->reference() ?? $bg;
            }

            // spacing
            if( $fragmentParent->spacing && $fragmentParent->spacing != 'FROMFRAGMENT' ) {
                $spacing = $fragmentParent->spacing->reference() ?? $spacing;
            }
        }

        $settings = array_merge(
            $layout['settings']  ?? [],
            $variant['settings'] ?? [],
            $bg['settings']      ?? [],
            $spacing['settings'] ?? []
        );

        $important = array_merge(
            $spacing['important'] ?? [],
            $bg['important']      ?? [],
            $variant['important'] ?? [],
            $layout['important']  ?? []
        );

        $settings['variant'] = $variant['value'] ?? null;
        $settings['layout']  = $layout['value']  ?? null;
        $settings['bg']      = $bg['value']      ?? null;
        $settings['spacing'] = $spacing['value'] ?? null;
        $settings['blockID'] = $block->id        ?? null;
        $settings['entryID'] = $block->owner->id ?? null;

        return array_merge(
            $settings,
            $important
        );
    }
}
