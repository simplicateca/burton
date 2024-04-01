<?php
/**
 * SiteModule - Normalize Block Twig Extension
 *
 * Splice any fragment block types into the block array.
 *
 * Merges the `settings` objects from the block variant, layout, and theme
 * fields (SelectPlus) into a single `settings` object.
 *
 * SelectPlus - https://github.com/simplicateca/craft-selectplus-field
 */

namespace modules\sitemodule\twigextensions;

use Craft;
use craft\elements\MatrixBlock;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;

class NormalizeBlockTwig extends AbstractExtension
{

    public function getFunctions() : array
    {
        return [ new TwigFunction( 'normalizeBlocks', [$this, 'normalize'] ) ];
    }


    public function normalize( $blocks = [], $builder = 'content', $defaultSettings ) : array
    {
        $blocks = $blocks ?? [];

        // If the blocks have already been normalized, there's nothing to do
        // short circuit the entire function and return now
        if( $this->doesThisLookNormalToYou( $blocks ) ) return $blocks;

        // Otherwise, lets get ready to enforce some conformity
        $entry = null;
        $deviants = [];
        foreach( $blocks as $block )
        {
            // If the block is an integer, assume it's an ID and query it
            $block = is_int($block) ? MatrixBlock::find()->id($block)->one() ?? [] : $block;

            // Prepare the block settings by merging the variant/layout/theme settings
            $settings = $this->mergeFieldSettings( $block );

            // Find the parent entry if it exists (and hasn't already been set)
            $entry = $entry ?? $block->owner ?? null;

            // If this is a Fragment Block, we need to splice all the blocks from
            // related content entries from the same type of builder field
            if( $settings['blockType'] == 'fragment' )
            {
                // A value of anything *EXCEPT* "FRAGMENT" in `settings.theme` indicates
                // we are to override all fragment blocks with the block theme
                $override = ( $settings['theme'] ?? null != 'FRAGMENT' )
                    ? [ "theme"         => (string) $settings["theme"],
                        "themeSettings" => $block->theme->settings ?? [] ]
                    : null;

                // And since technically there could be multiple fragments in the entry
                // field, and each fragment could have multiple blocks ..
                $fragments = $block->fragments->collect()->map( function ($frag) {
                    return $frag->bodyBuilder->all()
                        ?? $frag->sidebarBuilder->all()
                        ?? [];
                })->all();

                // add each fragment block to our normies array
                foreach( $fragments as $frag ) {
                    $deviants[] = [
                        'block'    => $frag,
                        'settings' => $this->mergeFieldSettings( $frag, $override )
                    ];
                }

                // next block
                continue;
            }

            // If we made it here, just treat it like a block to be normalized
            $deviants[] = [
                'block'    => $block,
                'settings' => $settings
            ];
        }

        // NORMAL VIEW
        // NORMAL VIEW
        // NORMAL VIEW
        $normies = [];
        foreach( $deviants as $unclean ) {
            $normies[] = $this->conform( [
                'object'   => $unclean['block'],
                'entry'    => $entry,
                'builder'  => $builder,
                'settings' => array_merge( $defaultSettings, $unclean['settings'] )
            ]);
        }

        // Now that we have all the normal blocks, we can add siblings settings
        // to each block and return the whole array
        return $this->siblingSettings( $normies );
    }


    private function doesThisLookNormalToYou( $blocks = null ) {
        if( !empty( $blocks ) && gettype( $blocks ) == 'array' ) {
            return ( $blocks[0]['_normalized'] ?? null );
        }
        return false;
    }


    private function siblingSettings( $blocks = [] ) {

        // this is ugly and i am not proud of it -- but it works
        // chatgpt or a 2nd year compsci student could probably do better.
        // my shame is immesurable and my day is ruined.
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


    private function conform( array $block ) : array
    {
        $block = array_merge( $block['object']->fieldValues ?? $block['object'] ?? [], $block );

        $block['settings'] = array_merge( $block['settings'], [
            'uuid'       => $block['object']->id ?? craft\helpers\StringHelper::UUID(),
            'builder'    => $block['builder']    ?? null,
            'entryID'    => $block['entry']->id  ?? null,
            'entryUrl'   => $block['entry']->url ?? null,
            'entryType'  => $block['entry']->type->handle    ?? null,
            'section'    => $block['entry']->section->handle ?? $block['settings']['section'] ?? null,
        ]);

        $block['_normalized'] = true;

        return $block;
    }


    private function mergeFieldSettings( $block, $override = [] ) : array
    {
        if( empty( $block ) ) {
            return [];
        }

        return array_merge( ...array_filter([
            $override['variantSettings'] ?? $block->variant->settings ?? [],
            $override['layoutSettings']  ?? $block->layout->settings  ?? [],
            $override['themeSettings']   ?? $block->theme->settings   ?? [],
            [
                'variant'   => $override['variant']   ?? (string) $block->variant ?? '',
                'layout'    => $override['layout']    ?? (string) $block->layout  ?? '',
                'theme'     => $override['theme']     ?? (string) $block->theme   ?? '',
                'blockType' => $override['blockType'] ?? $block->type->handle ?? $block->type ?? $block->blockType ?? ''
            ]
        ]));
    }
}