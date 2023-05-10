<?php
/**
 * Gearbox - Twig Extension
 *
 * Some new twig filters to help manipulate
 * strings of HTML (typically generated by Redactor fields).
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

use modules\gearbox\Gearbox;

use Craft;
use craft\elements\Entry;
use craft\elements\MatrixBlock;

use Twig\TwigFilter;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;

use Embed\Embed;
use Masterminds\HTML5;
use mmikkel\retcon\Retcon;
use Symfony\Component\DomCrawler\Crawler;

class GearboxTwigExtension extends AbstractExtension
{

    public function getName(): string
    {
        return 'Gearbox';
    }

    public function getFilters(): array
    {
        return [
            new TwigFilter( 'extractLeadingHeaders', [$this, 'extractHeaders',  ]),
            new TwigFilter( 'removeLeadingHeaders',  [$this, 'removeHeaders'  ]),

            new TwigFilter( 'extractTrailingButtons', [$this, 'extractButtons',  ]),
            new TwigFilter( 'removeTrailingButtons',  [$this, 'removeButtons'  ]),

            new TwigFilter( 'hex2rgb',  [$this, 'hex2rgb'  ]),

            new TwigFilter( 'groupButtons', [$this, 'groupButtons' ]),

            new TwigFilter( 'statFormat', [$this, 'statFormat' ]),
        ];
    }

    public function getFunctions(): array
    {
        return [
            new TwigFunction('leadingHeaders',  [$this, 'leadingHeaders']),
            new TwigFunction('trailingButtons', [$this, 'trailingButtons']),
            new TwigFunction('embedInfo', [$this, 'embedInfo']),
            new TwigFunction('hex2rgb', [$this, 'hex2rgb']),

            new TwigFunction('firstHref', [$this, 'firstHref']),

            new TwigFunction('normalizeBlocks', [$this, 'normalizeBlocks']),
        ];
    }


    public function extractHeaders( string|null $html = "" ): string
    {
        return $this->leadingHeaders( $html, 'extract' );
    }

    public function removeHeaders(  string|null $html = "" ): string
    {
        return $this->leadingHeaders( $html, 'remove' );
    }

    /**
     * Finds any leading header tags (h1-h6) at the beginning of a string of
     * HTML code and optionally extract or removes them, returning the result
     *
     * @param string $html   -- a string of well formatted html code
     * @param string $method -- extract|remove
     *
     * @return string
     */
    public function leadingHeaders( string|null $html = "", string $method = 'extract' ): string
    {
        // before we get started, lets yank out any eyebrows
        $eyebrow = (string) Retcon::getInstance()->retcon->only( $html, "div.eyebrow" ) ?? '';
        $html    = (string) Retcon::getInstance()->retcon->remove( $html, "div.eyebrow" );

        $libxmlUseInternalErrors = \libxml_use_internal_errors(true);
        $content = \mb_convert_encoding($html, 'HTML-ENTITIES', Craft::$app->getView()->getTwig()->getCharset());
        $doc = new \DOMDocument();
        $doc->loadHTML("<html><body>$content</body></html>", LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
        \libxml_use_internal_errors($libxmlUseInternalErrors);

        $crawler = new Crawler($doc);

        if( $crawler->filter('body') && $crawler->filter('body')->children() ) {
            $html = "";
            $foundLeading = false;

            foreach( $crawler->filter('body')->children() AS $node ) {
                if( !$foundLeading && in_array( strtolower( $node->tagName ), ['h1','h2','h3','h4','h5','h6'] ) ) {
                    $html .= ( $method == 'extract' ) ? $node->ownerDocument->saveHTML($node) : "";
                } else {
                    $foundLeading = true;
                    $html .= ( $method == 'remove'  ) ? $node->ownerDocument->saveHTML($node) : "";
                }
            }
        }

        // if we were extracting headers, return the eyebrow with the headers
        // otherwise do nothing since they're already been removed from the body
        if( $method == 'extract' ) { $html = $eyebrow . $html; }

        return $html;
    }


    public function extractButtons( string|null $html = "" ): string
    {
        return $this->trailingButtons( $html, 'extract' );
    }

    public function removeButtons(  string|null $html = "" ): string
    {
        return $this->trailingButtons( $html, 'remove' );
    }

    /**
     * Finds any buttons (or paragraphs that start with a button) at the end of a string of
     * HTML code and optionally extract or removes them, returning the result
     *
     * @param string $html   -- a string of well formatted html code
     * @param string $method -- extract|remove
     *
     * @return string
     */
    public function trailingButtons( string|null $html = "", string $method = 'extract' ): string
    {
        $libxmlUseInternalErrors = \libxml_use_internal_errors(true);
        $content = \mb_convert_encoding($html, 'HTML-ENTITIES', Craft::$app->getView()->getTwig()->getCharset());
        $doc = new \DOMDocument();
        $doc->loadHTML("<html><body>$content</body></html>", LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
        \libxml_use_internal_errors($libxmlUseInternalErrors);

        $crawler = new Crawler($doc);

        if( $crawler->filter('body') && $crawler->filter('body')->children() ) {
            $html = "";
            $foundTrailing = false;

            $allNodes = [];
            foreach( $crawler->filter('body')->children() AS $node ) {
                $allNodes[] = $node;
            }

            foreach( $crawler->filter('body > p')->last() AS $lastPara ) {
                $linkCrawler = new Crawler($lastPara);
                if( $linkCrawler ) {
                    // $buttons = $linkCrawler->filter('a.button');
                    $buttons = $linkCrawler->filter('a');

                    if( $buttons->count() ) {
                        $foundTrailing = true;
                    }
                }
            }

            $buttonNode = ( $foundTrailing ) ? array_pop( $allNodes ) : null;

            if( $method == 'extract' ) {
                return ( $buttonNode )
                    ? $buttonNode->ownerDocument->saveHTML($buttonNode)
                    : "";
            }

            foreach( $allNodes AS $node ) {
                $html .= $node->ownerDocument->saveHTML($node);
            }
        }

        return $html;
    }



    public function embedInfo( $url ) {

        $embedData = \Craft::$app->cache->getOrSet( "embedData-$url", function () use ($url) {
            $embed = new Embed();
            $info = $embed->get($url);

            $data = [
                'title'      => $info->title,
                'summary'    => $info->description,
                'url'        => (string) $info->url,
                'images'     => [ ['url' => (string) $info->image] ],
                'html'       => $info->code->html,
                'ratio'      => $info->code->ratio,
                'aspect'     => "",
                'provider'   => strtolower( $info->providerName ),
            ];

            if( (int) $data['ratio'] == 56 ) {
                $data['aspect'] = "aspect-video";
            }

            $data['html'] = (string) Retcon::getInstance()->retcon->attr( $data['html'], "blockquote.twitter-tweet", [
                'class' => 'mx-auto'
            ], false );

            $data['html'] = (string) Retcon::getInstance()->retcon->attr( $data['html'], "iframe", [
                'class' => $data['aspect'],
                'height' => '100%',
                'width' => '100%'
            ], true );

            return $data;

        }, 86400 );

        return $embedData;
    }


    public function hex2rgb( $colour ) {
        $colour = ltrim( $colour, '#' );

        if( strlen( $colour ) == 6 ) {
            list( $r, $g, $b ) = array( $colour[0] . $colour[1], $colour[2] . $colour[3], $colour[4] . $colour[5] );
        } elseif ( strlen( $colour ) == 3 ) {
            list( $r, $g, $b ) = array( $colour[0] . $colour[0], $colour[1] . $colour[1], $colour[2] . $colour[2] );
        } else {
            return false;
        }

        $r = hexdec( $r );
        $g = hexdec( $g );
        $b = hexdec( $b );

        return "$r,$g,$b";
    }


    public function firstHref( $html, $only = false ) {

        if( empty($html) ) { return false; }

        $libxmlUseInternalErrors = \libxml_use_internal_errors(true);
        $content = \mb_convert_encoding($html, 'HTML-ENTITIES', Craft::$app->getView()->getTwig()->getCharset());
        $doc = new \DOMDocument();
        $doc->loadHTML("<html><body>$content</body></html>", LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
        \libxml_use_internal_errors($libxmlUseInternalErrors);

        $crawler  = new Crawler($doc);
        $allLinks = $crawler->filter('body a');

        if( count( $allLinks ) == 1 || !$only ) {
            return $allLinks->first()->link()->getUri();
        }

        return false;
    }


    public function groupButtons( $html ) {

        if( substr($html,0,1) != '<' ) {
            return $html;
        }

        $libxmlUseInternalErrors = \libxml_use_internal_errors(true);
        $content = \mb_convert_encoding($html, 'HTML-ENTITIES', Craft::$app->getView()->getTwig()->getCharset());
        $doc = new \DOMDocument();
        $doc->loadHTML("<html><body>$content</body></html>", LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
        \libxml_use_internal_errors($libxmlUseInternalErrors);

        $crawler = new Crawler($doc);

        if( $crawler->filter('body') && $crawler->filter('body')->children() ) {
            $html = "";

            foreach( $crawler->filter('body')->children() AS $node ) {

                // if a paragraph has 2 (or more) a.button elements in it, including the first element
                // add the "cButtonGroup" class to the paragraph
                if( strtolower( $node->tagName ) == 'p' ) {
                    $paraCrawler = new Crawler($node);
                    $buttons        = $paraCrawler->filter('a.button');
                    $nonButtonLinks = $paraCrawler->filter('a');

                    if( count( $buttons ) >= 1 && count( $nonButtonLinks ) >= 2 ) {
                        $firstChild = $paraCrawler->children()->first();
                        if( strstr( $firstChild->attr('class'), 'button' ) ) {
                            $curClass   = $paraCrawler->attr('class') ?? '';

                            $groupClass = "cButtonGroup";

                            $style = $paraCrawler->attr('style') ?? null;
                            $style = strtolower( preg_replace( "/\s+/", "", $style ) );

                            if( strstr( $style, "text-align:left" ) ) {
                                $groupClass .= " cButtonGroup__left";
                            }

                            if( strstr( $style, "text-align:center" ) ) {
                                $groupClass .= " cButtonGroup__center";
                            }

                            if( strstr( $style, "text-align:right" ) ) {
                                $groupClass .= " cButtonGroup__right";
                            }

                            $node->setAttribute( 'class', $groupClass . " " . $curClass );
                        }
                    }
                }

                $html .= $node->ownerDocument->saveHTML($node);
            }
        }

        return $html;
    }


    // find any fragment blocks and splice them into the block array
    public function normalizeBlocks( $blockArray, $entry = [], $builder = 'content' ) {

        // if $entry is just an ID, look it up
        $entry  = is_int($entry) ? Entry::find()->id($entry)->one() ?? [] : $entry;

        $blocks = [];
        foreach( $blockArray as $block ) {

            // if $block is just an ID, look it up
            $isJustID  = is_int($block);
            $block     = $isJustID ? MatrixBlock::find()->id($block)->one() ?? [] : $block;

            $blockType = $block->type->handle ?? $block->type ?? null;

            if( $blockType == 'fragment' ) {
                // foreach( $block->fragments->all() as $fragment ) {
                //     $fragmentType = $fragment->fragmentType ?? null;
                //     if( $fragmentType == 'contentBuilder' && $fragment->contentBuilder->one() ) {
                //         foreach( $fragment->contentBuilder->all() as $fragBlock ) {
                //             $settings = $this->mergeBlockSettings( $fragBlock, $block );
                //             $blocks[] = $this->beforeRenderBlock([
                //                 'content'  => $fragBlock,
                //                 'entry'    => $entry,
                //                 'builder'  => $builder,
                //                 'settings' => $settings
                //             ]);
                //         }
                //     } else {
                //         $settings = $this->mergeBlockSettings( $fragment, $block );
                //         $blocks[] = $this->beforeRenderBlock([
                //             'content'  => $block,
                //             'entry'    => $entry,
                //             'fragment' => $fragment,
                //             'builder'  => $builder,
                //             'settings' => $settings
                //         ]);
                //     }
                // }
            } else {
                $settings = $this->mergeBlockSettings( $block );

                // if( $settings['scene']['twColor'] ?? false ) {
                //     $lastTwColor = $settings['scene']['twColor'];
                // } else {
                //     if( $settings['scene']['inherit'] ?? false ) {
                //         $settings['scene']['twColor'] = $lastTwColor;
                //     }
                // }

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
        $block['blockType']     = $block['fragment']->type->handle    ?? $block['content']->type->handle ?? $block['content']->type ?? $block['content']['type'] ?? '';

        return $block;
    }


    private function mergeBlockSettings( $block, $fragmentParent = null ) {

        if( is_array( $block ) && empty( $block ) ) {
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

        return array_merge(
            $settings,
            $important
        );
    }

    public function statFormat($number)
    {
       $cleanNumber = preg_replace( "/[^0-9]/", "", $number );
       $readable = array("", "K", "M", "B");
       $index=0;
       while($cleanNumber > 1000){
          $cleanNumber /= 1000;
          $index++;
       }

       $round = ( $readable[$index] == 'M' ) ? 0 : 1;

       $formatted = round($cleanNumber,$round);

       $firstChar = substr($number, 0, 1);
       $firstChar = in_array( $firstChar, ['+', '-', '>', '<', '$'] ) ? $firstChar : '&ensp;';

       $lastChar  = substr($number, -1);
       $lastChar  = in_array( $lastChar,  ['+', '-', '>', '<', '$'] ) ? $lastChar : '&ensp;';

       return "$firstChar<span data-stat-number='$formatted' class='cStatNumber' data-viewport>" . $formatted . "</span>" . $readable[$index] . $lastChar;
    }

}
