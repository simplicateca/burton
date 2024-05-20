<?php
/**
 * Card Layer Twig Functions
 *
 * Like its cousins (TextBase, ImageBase, BuilderBase, etc), the use of PHP to create
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


    public function CardBase( $content, $settings ) : mixed
    {
        $content  = (object) $content;
        $settings = (array)  $settings;

        /**
         * Figure out the type of content we're creating a card for
         *
         * If a `section` is provided, we'll use that, typically we're dealing with
         * Entries Elements, which all have a section property.
         *
         * -> https://craftcms.com/docs/5.x/reference/element-types/entries.html
         *
         * If a section isn't provided, but the content entry has an `id` property, we
         * can assume it's another element type (like an Asset or SuperTable row).
         *
         * !! TODO: Include all Craft Element Types + Commerce Products + Verbb Events
         * https://craftcms.com/docs/5.x/system/elements.html#element-types
         *
         *
         */
        $section   = $content->section->handle ?? $content->section ?? null;
        $entrytype = $content->type->handle    ?? $content->type    ?? null;

        // if( !$section && $content->id ?? null ) {
        //     // {% set itemtype = className( content ) ??? null | upper %}
        //     // {% if itemtype == 'ASSET'      %}{% set section = 'assets' %}{% endif %}
        //     // {% if itemtype == 'SUPERTABLE' %}{% set section = 'bits'   %}{% endif %}
        // }

        $eyebrow  = Retcon::getInstance()->retcon->only( $content->summary ?? '', 'div.eyebrow' );
        $headline = $this->_cardheadline( $content->summary ?? '' ) ?? $content->title ?? null;

        $label = $this->_cardlabel( $content->label ?? null )
              ?? $this->_cardlabel( $eyebrow )
              ?? $this->_cardlabel( $headline );

        $summary = $this->_cardtext( $content->summary ?? '' ) ?? $this->_cardtext( $content->headline ?? '' );
        $summary = ( empty( $summary ) && $content->text ?? null )
            ? $this->_truncate( $this->_cardtext( $content->text ), 150 )
            : $summary;

        $card = [
            '_element'  => $content,
            'headline'  => trim( $headline ),
            'longtext'  => $content->text ?? '',
            'summary'   => $summary,
            'eyebrow'   => trim( $eyebrow ),
            'section'   => $section,
            'images'    => $this->_cardimages( $content->images ?? null ),
            'label'     => $label,
            'type'      => $entrytype,
            'url'       => $content->url ?? null,
        ];

        return $card;
    }



    private function _cardheadline( $content = "" ) : string|null {
        $headline = $content;
        $headline = Retcon::getInstance()->retcon->only( $headline, 'h3' );
        $headline = Retcon::getInstance()->retcon->change( $headline, ['h3'], false );
        $headline = Retcon::getInstance()->retcon->change( $headline, ['a', 'button'], 'span' );
        $headline = Retcon::getInstance()->retcon->removeEmpty( $headline );

        if( empty( trim( strip_tags($headline) ) ) ) { return null; }

        return $headline;
    }


    private function _cardtext( $content = "" ) : string|null {

        $summary = $content;
        $summary = Retcon::getInstance()->retcon->remove( $summary, ['h1', 'h3', '.eyebrow'] );
        $summary = Retcon::getInstance()->retcon->remove( $summary, ['img', 'figure', 'iframe'] );
        $summary = Retcon::getInstance()->retcon->removeEmpty( $summary );

        if( empty( trim( strip_tags($summary) ) ) ) { return null; }

        $summary = Retcon::getInstance()->retcon->change( $summary, ['h2', 'h3', 'h4', 'h5', 'h6', 'ol', 'li', 'div', 'p', 'a', 'button'], 'span' );

        return "<p>{$summary}</p>";
    }


    private function _cardlabel( $content = "" ) : string|null {
        return trim( strip_tags($content) );
    }


    private function _cardimages( $images = null ) : mixed {
        $cardimages = is_string( $images ) ? [$images] : $images;
        $cardimages = is_object( $images ) ? $images->all() : $images;
        return $cardimages;
    }


    private function _truncate( $string, $length = 150 ) : string
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