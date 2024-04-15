<?php
/**
 * Card Layer Twig Functions
 *
 * Like its cousins (TextBase, ImageBase, BlockBase, etc), the use of PHP to create
 *   this macro instead of defining it within Twig is a bit of a necessasry evil.
 *
 *   Twig lacks a way to return variables from inline macros, which makes it very hard
 *   to define a consistent data structure for complex elements. Without this, there
 *   would be too much code duplication and inconsistency.
 *
 *   If Twig had a more robust way to return a variable from an inline {% macro %}
 *   exectution (without rendering it), `CardBase` could easily exist as Twig code.
 *
 *   Maintains path and inheritence consistency when generating content cards.
 *
 * This extension is not *required*, but it provides a convenient way to maintain consistency
 * in the card object across templates and avoid unnecessary code duplication in Twig templates.
 *
 * If Twig allowed objects to be returned from inline {% macro %} functions, this extension
 * would not be necessary.
 *
 * Creates a base card object from a given entry.
 *
 * This extension is not required, but it provides a convenient way to maintain consistency
 * in the card object across templates and avoid unnecessary object creation in Twig templates.
 *
 */

namespace modules\sitemodule\twigextensions;

use Craft;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;
use mmikkel\retcon\Retcon;

class CardBaseTwig extends AbstractExtension
{
    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'CardBase', [ $this, 'CardBase' ] ),
            new TwigFunction( 'cardbase', [ $this, 'CardBase' ] ),
        ];
    }


    public function CardBase( $carditem, $settings ) : mixed
    {
        $carditem = (object) $carditem;
        $settings = (object) $settings;

        /**
         * Figure out the type of content we're creating a card for
         *
         * If a `section` is provided, we'll use that, typically we're dealing with
         * Entries Elements, which all have a section property.
         *
         * -> https://craftcms.com/docs/5.x/reference/element-types/entries.html
         *
         * If a section isn't provided, but the carditem entry has an `id` property, we
         * can assume it's another element type (like an Asset or SuperTable row).
         *
         * !! TODO: Include all Craft Element Types + Commerce Products + Verbb Events
         * https://craftcms.com/docs/5.x/system/elements.html#element-types
         *
         */
        $section   = $carditem->section->handle ?? $carditem->section ?? $settings->section   ?? null;
        $entrytype = $carditem->type->handle    ?? $carditem->type    ?? $settings->entrytype ?? null;

        if( !$section && $carditem->id ?? null ) {
            // {% set itemtype = className( carditem ) ??? null | upper %}
            // {% if itemtype == 'ASSET'      %}{% set section = 'assets' %}{% endif %}
            // {% if itemtype == 'SUPERTABLE' %}{% set section = 'bits'   %}{% endif %}
        }

        $cardlayer  = $settings->cardlayer ?? 'default';

        $cardimages = ( $carditem->images ?? null ) ? $carditem->images : null;
        $cardimages = is_string( $cardimages ) ? [$cardimages] : $cardimages;
        $cardimages = is_object( $cardimages ) ? $cardimages->all() : $cardimages;

        $headline   = trim( $carditem->headline ?? $carditem->title ?? null );
        $eyebrow    = Retcon::getInstance()->retcon->only( $headline, 'div.eyebrow' ) ?? null;
        $headline   = Retcon::getInstance()->retcon->change( $headline, ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'div'], false );
        $headline   = Retcon::getInstance()->retcon->remove( $headline, ['img', 'a', 'figure', 'iframe', 'div.eyebrow'] );

        $fulltext   = trim( $carditem->text ?? null );
        $summary    = trim( $carditem->summary ?? $carditem->dek ?? null );

        if( $fulltext && empty( $summary ) ) {
            $summary = $this->truncate( $fulltext, 150 );
        }

        if( $summary && !in_array( strtolower( substr( $summary, 0, 3) ), ['<p ', '<p>'] ) ) {
            $summary = '<p>' . $summary . '</p>';
        }

        $card = [
            '_carditem' => $carditem,
            'cardlayer' => $cardlayer,
            'headline'  => trim( $headline ),
            'fulltext'  => $fulltext,
            'summary'   => $summary,
            'eyebrow'   => trim( $eyebrow ),
            'section'   => $section,
            'action'    => $carditem->action ?? $settings->action ?? null,
            'images'    => $cardimages,
            'type'      => $entrytype,
            'path'      => $settings->path ?? [
                "_site/card.".$cardlayer.".".$section.".".$entrytype,
                "_site/card.".$cardlayer.".".$section,
                "_site/card.".$cardlayer,
                "_site/card",
                "_core/card"
            ],
            'url' => $carditem->url  ?? null,
        ];

        // Card Label - sometimes used for tabs or accordions titles
        $eyebrow_label  = trim( strip_tags( $card['eyebrow'] ) );
        $headline_label = trim( strip_tags( $card['headline'] ) );
        $card['label']  = empty( $eyebrow_label ) ? $headline_label : $eyebrow_label;

        return $card;
    }



    private function truncate( $string, $length = 150 ) : string
    {
        $string = strip_tags( $string );

        if (strlen($string) > $length)
        {
            $string = wordwrap($string, $length);
            $string = substr($string, 0, strpos($string, "\n"));
        }

        return $string;
    }

}