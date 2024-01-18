<?php
/**
 * Gearbox - Rich Html Processing Twig Extension
 *
 * Does processing of rich html strings to perform additional cleanup, and to
 * extract and manipulate the contents
 * for more control over the layout and presentation of the content.
 *
 * Including:
 * ------------------------------------------------------
 * - Remove / extract leading headers (h1,h2,h3,etc)
 * - Remove / extract trailing buttons (a.button)
 * - Remove / extract div.eyebrow elements
 * - Wrap side-by-side buttons in a <p> with p.button-group
 *
 */

namespace modules\gearbox\twigextensions;

use Craft;
//use craft\helpers\StringHelper;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;
use mmikkel\retcon\Retcon;

class RichHtmlTwigExtension extends AbstractExtension
{

    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'richHtml', [$this, 'richHtml'] ),
        ];
    }


    public function richHtml( string|null $html = "" ): array
    {
        $cacheKey  =  "textParts-" . md5($html);
        $textParts = \Craft::$app->cache->getOrSet( $cacheKey, function () use ($html) {

            // selector configs
            // TODO: move these into a config file
            $settings = [
                'eyebrowSelector'     => "div.eyebrow:first-child",
                'headlineSelectors'   => ['h1:first-child','h2:first-child','h3:first-child'],
                'defaultMarkSelector' => "mark:not(.m1):not(.m2)",
                'defaultMarkClass'    => "m1",
                'markSelectors'       => ['mark.m1','mark.m2'],
                'ctaSelector'         => "a.button",
                'lastSmallSelector'   => "p.small:last-child",
                'trailingCtaSelector' => "p[data-has-buttons]:last-child",
                'figureClassPrefix'   => "imageCard",
            ];

            // keep a copy of the original unchanged text body
            $processed = $html;
            $textParts = [
                'eyebrow'   => null,
                'headline'  => null,
                'cta'       => null,
                'body'      => null,
                'oAlign'    => null,
            ];

            if( !$html ) {
                return $textParts;
            }

            // give all <a> tags a data-href attribute that matches the value of their current
            // href attribute, making it easier and more accessible to target with JS/CSS
            $processed = (string) Retcon::getInstance()->retcon->renameAttr( $processed, "a", [ 'href' => 'data-ahref' ] );
            $processed = preg_replace('/data-ahref="(.*?)"/', "href=\"$1\" data-ahref=\"$1\"", $processed );


            // if only one link exists in the string, give it a data-only-link attribute to make it
            // targetable with JS/CSS so that it may be styled or treated differently.
            if( mb_substr_count( mb_strtolower( $processed ), "</a>" ) == 1 ) {
                $processed = (string) Retcon::getInstance()->retcon->attr( $processed, "a", [ "data-only-link" => true ] );
            }


            // process the top level DomElements in the rich html string for:
            //  - embedded rich media (images, videos, url strings, etc)
            //  - replace style="text-align:left|center|right" attriutes with class names
            //  - paragraphs that contain one or more buttons
            $processed = $this->processTopLevelDomElements( $processed, $settings );


            // extract the div.eyebrow element appearing before any other element in the html string
            $textParts['eyebrow'] = $this->retconOnly( $processed, $settings['eyebrowSelector'] );
            $processed = $this->retconRemove( $processed, $settings['eyebrowSelector'] );

            // TODO: automatically add id to eyebrow
            // {% set eyebrowText = ( eyebrow ?? '' )|striptags|trim|lower|ascii|kebab  %}
            // {% if eyebrowText %}
            //     {% set eyebrow = eyebrow|retconAttr( 'div', { id: eyebrowText }) %}
            // {% endif %}


            // find the alignment of the opening element.
            // it's important that this not happen until after the eyebrow has been removed, but
            // before any of the leading headers are removed, as the opening alignment could be
            // on a headline, but it could also be on a <p> or heaven forbid a <ul> or <ol>.
            $textParts['oAlign'] = $this->openingBlockAlignment( $processed, $settings );



            // now we can extract any h1,h2,h3 elements that appear before any other elements,
            // and move them to the headline section of the textParts array.
            foreach( $settings['headlineSelectors'] as $headerTagSelector ) {
                $textParts['headline'] .= $this->retconOnly( $processed, $headerTagSelector );
                $processed = $this->retconRemove( $processed, $headerTagSelector );
            }


            // if we could detect a specific alignment on the first block element in the html string,
            // the we could try to replicate that alignment on the eyebrow element which doesn't have
            // it's own alignment settings. this is a bit of a hack, but it works.
            if( $textParts['oAlign'] && $textParts['eyebrow'] ) {
                $mx = "mr-auto";
                $mx = 'center' == $textParts['oAlign'] ? 'mx-auto' : $mx;
                $mx = 'right'  == $textParts['oAlign'] ? 'ml-auto' : $mx;

                // manipulate the eyebrow element alignment
                $textParts['eyebrow'] = (string) Retcon::getInstance()->retcon->attr(
                    $textParts['eyebrow'],
                    '.eyebrow',
                    [ 'class' => $mx ],
                    false // overwrite
                );
            }


            // find any "kickers" at the bottom of the html, just before any (otherwise)
            // trailing button(s). these small/micetype paragraphs are typically used to
            // provide additional context to the button(s) above them, and should be extracted
            // to the cta section of the textParts array as well.
            // these  sometimes sit below a trailing buttons and should be extracted with it
            $lastSmallPara = $this->retconOnly( $processed, $settings['lastSmallSelector'] );
            $processed = $this->retconRemove( $processed, $settings['lastSmallSelector'] );

            // grab the last paragraph and test to see if it contains buttons. or more specifically,
            // test if the first child of last paragraph is a link of some kind (typically a call-to-action)
            $lastButtonPara = $this->retconOnly( $processed, $settings['trailingCtaSelector'] );
            $processed = $this->retconRemove( $processed, $settings['trailingCtaSelector'] );

            // if we found a trailing button paragraph, save it separately with the last small paragraph (if any).
            // otherwise, slap push any last small paragraph element on to the bottom of the processed html string
            if( $lastButtonPara ) {
                $textParts['cta'] = $lastButtonPara . $lastSmallPara;
            } else {
                $processed .= $lastSmallPara;
            }

            $textParts['body'] = $processed;

            return $textParts;

        }, 86400 );

        return $textParts;
    }


    private function retconOnly( $html, $selector ) {
        $html = (string) Retcon::getInstance()->retcon->only( "<template>$html</template>", "template $selector" ) ?? null;
        return trim( $html );
    }


    private function retconAttr( $html, $selector, $attr, $overwrite = true ) {
        $html = (string) Retcon::getInstance()->retcon->attr( $html, $selector, $attr, $overwrite ) ?? null;
        return trim( $html );
    }

    private function retconRemove( $html, $selector ) {
        $html = (string) Retcon::getInstance()->retcon->remove( "<template>$html</template>", "template $selector" );
        $html = (string) Retcon::getInstance()->retcon->change( $html, "template", false );
        return trim( $html );
    }


    private function processTopLevelDomElements( $html, $settings ) {

        if( $nodes = $this->_html2nodes( $html ) ) {
            $html = "";
            foreach( $nodes AS $node ) {
                if( $node ) {

                    $node = $this->setNodeAlignment( $node, $settings );

                    $nodeHtml = "";
                    switch( mb_strtolower( $node->tagName ?? "" ) ) {
                        // case 'figure':
                        //     $nodeHtml = $this->generateFigureHtml( $node, $settings['figureClassPrefix'] ?? null );
                        //     break;
                        case 'p':
                            $nodeHtml = $this->generateParagraphHtml( $node, $settings['ctaSelector'] ?? null );
                            break;
                        default:
                            $nodeHtml = $node->ownerDocument->saveHTML($node);
                    }

                    $html .= $nodeHtml;
                }
            }
        }

        return $html;
    }


    private function openingBlockAlignment( $html, $settings ) {

        $classLeft   = $settings["classLeft"]   ?? "text-left";
        $classCenter = $settings["classCenter"] ?? "text-center";
        $classRight  = $settings["classRight"]  ?? "text-right";

        if( $nodes = $this->_html2nodes( $html ) ) {
            foreach ( $nodes as $key => $node) {
                $class = $node->getAttribute('class') ?? '';
                if( mb_strstr( $class, 'eyebrow' ) ) { continue; }
                foreach( [$classLeft,$classCenter,$classRight] AS $align ) {
                    if( mb_strstr( $class, $align ) ) {
                        if( $align == $classLeft   ) { return 'left';   }
                        if( $align == $classCenter ) { return 'center'; }
                        if( $align == $classRight  ) { return 'right';  }
                    }
                }
                return null;
            }
        }

        return null;
    }


    // private function generateFigureHtml( $node, $figureClassPrefix )
    // {
    //     $view = Craft::$app->getView();
    //     $templateMode = $view->getTemplateMode();
    //     $view->setTemplateMode($view::TEMPLATE_MODE_SITE);

    //     $figureHtml   = $node->ownerDocument->saveHTML( $node );
    //     $figureClass  = $node->getAttribute('class') ?? "";
    //     $cardTemplate = mb_ereg_replace( $figureClassPrefix, '', $figureClass );

    //     // TODO: Clean-up this dumb ugly bullshit
    //     // ------------------------------------------------------------------------
    //     $figureLink     = $this->retconOnly( $figureHtml, "a" );
    //     $figureImage    = $this->retconOnly( $figureHtml, "img" );
    //     $figureIframe   = $this->retconOnly( $figureHtml, "iframe" );
    //     $figureCaption  = $this->retconOnly( $figureHtml, "figcaption" );
    //     $linkNodes      = $this->_html2nodes( $figureLink   ) ?? [];
    //     $imageNodes     = $this->_html2nodes( $figureImage  ) ?? [];
    //     $iframeNodes    = $this->_html2nodes( $figureIframe ) ?? [];
    //     $linkNode       = null;
    //     $imageNode      = null;
    //     $iframeNode     = null;
    //     foreach( $linkNodes AS $node   ) { $linkNode   = $node; break; }
    //     foreach( $imageNodes AS $node  ) { $imageNode  = $node; break; }
    //     foreach( $iframeNodes AS $node ) { $iframeNode = $node; break; }
    //     // ------------------------------------------------------------------------

    //     $cleanCardTmplName = trim( mb_ereg_replace('/[^\w\d\-\_]+/', '', $cardTemplate ) ) ?? 'basic';
    //     $cardComponentPath = $iframeNode
    //         ? "_cards/media/"
    //         : "_cards/image/";

    //     $cardTwigInclude   = '{% include "' . $cardComponentPath . $cleanCardTmplName . '" ignore missing %}';

    //     $cardSettings = [
    //         'figureID'     => $node->getAttribute('id') ?? StringHelper::UUID(),
    //         'link'         => $linkNode  ? $linkNode->getAttribute('href') ?? null : null,
    //         'image'        => $imageNode ? $imageNode->getAttribute('src') ?? null : null,
    //         'altText'      => $imageNode ? $imageNode->getAttribute('alt') ?? $imageNode->getAttribute('title') ?? null : null,
    //         'imageCaption' => (string) Retcon::getInstance()->retcon->change( $figureCaption, "figcaption", false ) ?? ""
    //     ];

    //     $newFigureHtml = (string) $view->renderString( $cardTwigInclude, [ 'settings' => $cardSettings ] );

    //     $view->setTemplateMode($templateMode);

    //     return trim( $newFigureHtml ?? $figureHtml );
    // }


    // convert:
    //   style="text-align:left/center/right"
    // to:
    //   class="text-left/text-center/text-right"
    private function setNodeAlignment( $node, $settings )
    {
        $classLeft   = $settings["classLeft"]   ?? "text-left";
        $classCenter = $settings["classCenter"] ?? "text-center";
        $classRight  = $settings["classRight"]  ?? "text-right";

        $nodeStyle = $node->getAttribute('style') ?? "";
        $nodeClass = $node->getAttribute('class') ?? "";
        $nodeStyle = mb_strtolower( mb_ereg_replace( ' ', '', $nodeStyle ) );

        if( strstr( $nodeStyle, "text-align:left" ) ) {
            $node->setAttribute( "class", implode( " ", [$nodeClass, $classLeft] ) );
        }

        if( strstr( $nodeStyle, "text-align:center" ) ) {
            $node->setAttribute( "class", implode( " ", [$nodeClass, $classCenter] ) );
        }

        if( strstr( $nodeStyle, "text-align:right" ) ) {
            $node->setAttribute( "class", implode( " ", [$nodeClass, $classRight] ) );
        }

        // clean up the style tag
        $nodeStyle = mb_ereg_replace( 'text-align:left',   '', $nodeStyle );
        $nodeStyle = mb_ereg_replace( 'text-align:center', '', $nodeStyle );
        $nodeStyle = mb_ereg_replace( 'text-align:right',  '', $nodeStyle );

        empty( $nodeStyle )
            ? $node->removeAttribute( "style" )
            : $node->setAttribute( "style", $nodeStyle );

        return $node;
    }


    private function generateParagraphHtml( $node, $ctaSelector )
    {
        $paraHtml = $node->ownerDocument->saveHTML( $node );

        if( $this->retconOnly( $paraHtml, $ctaSelector ) ) {
            $paraHtml = (string) Retcon::getInstance()->retcon->attr( $paraHtml, 'p', ['data-has-buttons' => true] );
        }

        return trim( $paraHtml );
    }


    private function _html2nodes( $html )
    {
        $html = \mb_convert_encoding($html, 'HTML-ENTITIES', Craft::$app->getView()->getTwig()->getCharset());
        if( mb_substr($html,0,1) != '<' ) {
            return null;
        }

        $libxmlUseInternalErrors = \libxml_use_internal_errors(true);
        $doc = new \DOMDocument();
        $doc->loadHTML("<template>$html</template>", LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
        \libxml_use_internal_errors($libxmlUseInternalErrors);

        $crawler = new \Symfony\Component\DomCrawler\Crawler($doc);
        return $crawler->filter('template')->children();
    }

}