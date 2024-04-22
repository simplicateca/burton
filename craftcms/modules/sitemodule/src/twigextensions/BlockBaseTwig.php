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

/**------------------------------------------------------------------------------------/

    BuilderBase() is responsible for 3 primary things:

 1) Splicing Blocks added via Fragments into the list of blocks to be rendered.

 2) Merging individual block `settings` objects with the values from each blocks
    attribute fields (i.e. variant, layout, theme, and source).

    Block attribute fields are usually SelectPlus custom fields. When true, the
    `settings` object also gets merged with additional values from those fields,
    which may include Virtual Fields values or their own set of default `settings`.

 -> https://github.com/simplicateca/craft-selectplus-field
 -> `templates/_config`

    If so, This includes values from any Virtual Fields or default `settings` associated
    with the JSON config for each SelectPlus field. See: `templates/_config`

 3) Normalizing each block object using the BlockBase() macro (which can be found
    in the same file listed above).


    Normalized Blocks and BlockBase()
/**------------------------------------------------------------------------------------/
    Blocks returned from BuilderBase() are normalized via the BlockBase() function.

    Looping though a Matrix builder typically yields individual MatrixBlock elements.
 -> https://docs.craftcms.com/api/v4/craft-elements-matrixblock.html

     However, since we want to be pass additional `settings` information with each
    block, we need to modify the structure of what gets returned when looping
    through a Matrix builder.

    The object returned from BlockBase() starts off as the value returned by calling
    `block.fieldValues`, which contains the values for all custom fields.
 -> https://docs.craftcms.com/api/v4/craft-base-element.html#property-fieldvalues

     We then add a property for `settings` and also store the original MatrixBlock
    element in `_block` so that it can still be accessed if needed.

    A normalized Image Block object would look like this:
/**------------------------------------------------------------------------------------/
    {
        text    : "<p>Content from CKEditor / Redactor field</p>",
        images  : <AssetQueryObject>
        variant : <SelectPlusFieldObject>,
        layout  : <SelectPlusFieldObject>,
        theme   : <SelectPlusFieldObject>,
        source  : <SelectPlusFieldObject>,
        settings: {
            variant  : 'default',
            layout   : 'default',
            theme    : 'default',
            source   : 'default',
            section  : 'pages',
            entrytype: 'default',
            builder  : 'default',
            blocktype: 'image',
            ...etc
        },
        '_block'     : <MatrixBlockObject>
        '_noramlized': true,
    }
/**----------------------------------------------------------------------------------**/
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
                $dirtyblocks[] = ['block' => $block, 'attr'=>$attr, '_parent'=>null];
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

                    // Make blocks being spliced in from a Fragment Block report as being
                    // owned by the Entry that the original Fragment Block exists on.
                    // Otherwise these blocks will report as being owned by an Entry
                    // within the Reusable Blocks Channel Section.
                    if( $dirty['_parent']->owner ?? null ) {
                        $dirty['block']->setOwner( $dirty['_parent']->owner );
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

        // Which can help with effects or transition elements between blocks/themes.
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

        return [
            'base' => [
                'blockid'   => isset( $b['id'] )     ? $b['id']->value      ?? $b['id'] : '',
                'source'    => isset( $b['source'] ) ? $b['source']->value  ?? $b['source']  : '',
                'variant'   => isset( $b['variant']) ? $b['variant']->value ?? $b['variant'] : '',
                'layout'    => isset( $b['layout'] ) ? $b['layout']->value  ?? $b['layout']  : '',
                'theme'     => isset( $b['theme']  ) ? $b['theme']->value   ?? $b['theme']   : '',
                'blocktype' => isset( $b['type']   ) ? $b['type']->handle   ?? $b['type']    : '',
            ],
            'variant' => isset( $b['variant']->settings  ) ? $b['variant']->settings : [],
            'layout'  => isset( $b['layout']->settings   ) ? $b['layout']->settings  : [],
            'theme'   => isset( $b['theme']->settings    ) ? $b['theme']->settings   : [],
            'source'  => isset( $b['source']->settings   ) ? $b['source']->settings  : [],
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
                //$blocks[$key]['settings']['themeprev'] = $blocks[$key-1]['settings']['theme'] ?? null;
            }

            if( $blocks[$key+1]['settings'] ?? null )
            {
                $blocks[$key]['next'] = $blocks[$key+1]['settings'];
                //$blocks[$key]['settings']['themenext'] = $blocks[$key+1]['settings']['theme'] ?? null;
                //$blocks[$key+1]['settings']['inherittheme'] = ( $blocks[$key]['settings']['theme'] == $blocks[$key+1]['settings']['theme'] );
            }

            if( $blocks[$key]['settings']['theme'] == 'INHERIT' || ( $blocks[$key]['settings']['inherittheme'] ?? null ) )
            {
                $blocks[$key]['settings']['theme'] = $blocks[$key-1]['settings']['theme'] ?? null;
            }
        }

        return $blocks;
    }
}