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
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;

class BlockBaseTwig extends AbstractExtension
{

    public function getFunctions() : array
    {
        return [
            new TwigFunction( 'BuilderBase', [ $this, 'BuilderBase' ] ),
            new TwigFunction( 'builderbase', [ $this, 'BuilderBase' ] ),

            new TwigFunction( 'BlockBase', [ $this, 'BlockBase' ] ),
            new TwigFunction( 'blockbase', [ $this, 'BlockBase' ] ),
        ];
    }



    public function BlockBase( $block = null, $settings = [] ) {

        $base = is_object( $block ) ? $block->fieldValues ?? [] : (array) $block;

        if( $block && empty( $settings ) ) {
            $attrs = $this->_attributes( $block );
            $settings = array_merge(
                $attrs['base'],
                $attrs['source'],
                $attrs['theme'],
                $attrs['layout'],
                $attrs['variant'],
            );
        }

        $base['settings']    = $settings;
        $base['_block']      = $block;
        $base['_normalized'] = true;
        return $base;
    }


    // Find all the fragments that exist as part of this block
    // ----------------------------------------------------------------------------------
    // Fragment blocks may contain more than one block and we need to splice them into
    // the block array so that they can be normalized. Luckily fragments can not contain
    // other fragments so we don't have to go recursive on this shit.
    private function FragmentBase( $block ) {
        return property_exists( $block, 'fragments' ) && $block->fragments->one()
          ? $block->fragments->collect()->map( function ($frag) {
                return $frag->bodyBuilder->all()
                    ?? $frag->sidebarBuilder->all()
                    ?? [];
            })->all() ?? []

          : [];
    }



    public function BuilderBase( $blocks = [], $common = [] ) : array
    {
        $blocks = $blocks ?? [];
        $common = $common ?? [];

        // Track attributes of the last block with an inheritable theme
        $lasttheme = [
            'base'  => ['theme' => 'default'],
            'theme' => []
        ];

        // Otherwise, lets get ready to enforce some conformity
        $normals = [];
        foreach( $blocks as $block )
        {
            // If this block has already been normalized, no need to do it again
            if( $this->_isnormal( $block ) ) {
                $normals[] = $block;
                continue;
            }

            $attr = $this->_attributes( $block );

            // Collect children of Fragment Blocks, and add them to an array to be cleaned
            $dirtyblocks = [];
            if( strtolower( $attr['base']['blocktype'] ) == 'fragment' ) {
                foreach( $this->FragmentBase( $block ) AS $frag ) {
                    $fragattr = $this->_attributes( $frag );
                    $dirtyblocks[] = ['block'=>$frag, 'attr'=>$fragattr, '_parent'=>$block];
                }
            } else {
                $dirtyblocks[] = ['block'=>$block, 'attr'=>$attr, '_parent'=>null];
            }


            // Now that we have one (or more) dirty blocks to clean .. start scrubbing
            foreach( $dirtyblocks as $dirty )
            {
                $attrs = $dirty['attr'];

                // If this Block was a Fragment..
                // ----------------------------------------------------------------------
                // If the original Fragment Block has a theme value of anything other
                // than 'FRAGMENT', then we're overriding theme settings.
                if( $dirty['_parent'] ?? null ) {
                    $parent = $this->_attributes( $dirty['_parent'] );
                    if( $parent['base']['theme'] != 'FRAGMENT' ) {
                        $attrs['base']['theme'] = $parent['base']['theme'] ?? 'default';
                        $attrs['theme'] = array_merge( $parent['theme'], $attrs['theme'] ?? [] );
                    }
                }

                // If we are inheriting the theme from the previous block, merge the
                // previous block's theme settings into this block's theme settings.
                if( $attrs['base']['theme'] == 'INHERIT' ) {
                    $attrs['base']['theme'] = $lasttheme['base']['theme'] ?? 'default';
                    $attrs['theme'] = array_merge( $lasttheme['theme'], $attrs['theme'] ?? [] );

                // Otherwise, this becomes the last block with an inheritable theme
                } else { $lasttheme = $attrs; }

                // Slam all the attribute settings together into a single settings hash
                $settings = array_merge(
                    $attrs['base'],
                    $attrs['source'],
                    $attrs['theme'],
                    $attrs['layout'],
                    $attrs['variant'],
                );

                // Finally, use the original common settings passed in as a backup
                // for any missing settings in the block's settings hash
                $settings = array_merge( $common, $settings );

                $normals[] = $this->BlockBase( $dirty['block'], $settings );
            }
        }

        // Sibling Themes is a quick a dirty function that includes the `settings` hash
        // for the `next` & `prev` block into the `settings` hash of the current block.
        //
        // This helps with effects or elements that transition between block themes.
        $normals = $this->_siblingthemes( $normals );


        // Finally return an array of normalized, renderable blocks
        return $normals;
    }


    private function _isnormal( $block = null ) {
        return ( $block && is_array( $block ) && isset( $block['_normalized'] ) );
    }


    private function _attributes( $b ) : array
    {
        if( empty( $b ) ) { return []; }

        $b = (object) $b;

        return [
            'base' => array_filter([
                'source'    => $b->source->value    ?? '',
                'variant'   => $b->variant->value   ?? '',
                'layout'    => $b->layout->value    ?? '',
                'theme'     => $b->theme->value     ?? 'default',
                'blocktype' => $b->type->handle ?? $b->type ?? $b->blocktype ?? 'html',
            ]),
            'variant' => ( $b->variant ?? null && $b->variant->settings ) ? array_filter( $b->variant->settings ) : [],
            'layout'  => ( $b->layout  ?? null && $b->layout->settings  ) ? array_filter( $b->layout->settings  ) : [],
            'theme'   => ( $b->theme   ?? null && $b->theme->settings   ) ? array_filter( $b->theme->settings   ) : [],
            'source'  => ( $b->source  ?? null && $b->source->settings  ) ? array_filter( $b->source->settings  ) : [],
        ];
    }



    private function _siblingthemes( $blocks = [] ) {

        // this is ugly and i am not proud of it -- but it works
        // chatgpt or a 2nd year compsci student could probably do better.
        // my shame is immesurable and my day is ruined.
        foreach( $blocks AS $key => $block )
        {
            if( $blocks[$key-1]['settings'] ?? null )
            {
                $blocks[$key]['prev'] = $blocks[$key-1]['settings'];
                $blocks[$key]['settings']['themeprev'] = $blocks[$key-1]['settings']['theme'] ?? null;
            }

            if( $blocks[$key+1]['settings'] ?? null )
            {
                $blocks[$key]['next'] = $blocks[$key+1]['settings'];
                $blocks[$key]['settings']['themenext'] = $blocks[$key+1]['settings']['theme'] ?? null;
                $blocks[$key+1]['settings']['inherittheme'] = ( $blocks[$key]['settings']['theme'] == $blocks[$key+1]['settings']['theme'] );
            }

            if( $blocks[$key]['settings']['theme'] == 'INHERIT' || ( $blocks[$key]['settings']['inherittheme'] ?? null ) )
            {
                $blocks[$key]['settings']['theme'] = $blocks[$key-1]['settings']['theme'] ?? null;
            }
        }

        return $blocks;
    }
}