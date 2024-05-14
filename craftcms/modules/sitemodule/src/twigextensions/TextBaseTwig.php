<?php
    /**
     * TextBase - Better Processing for <HtmlFieldData> strings
     *
     * TODO: This should be its own installable and configurable plugin.
     *
     * Cleans up strings of <HtmlFieldData> and splits them into different parts that can
     * be useful for improving the presentation of individual CKEditor fields without
     * increasing the complexity of the UI.
     *
     */

    namespace modules\sitemodule\twigextensions;

    use Craft;
    use Twig\TwigFunction;
    use Twig\Extension\AbstractExtension;
    use mmikkel\retcon\Retcon;

    class TextBaseTwig extends AbstractExtension
    {
        // TODO: move these into a config file
        const SELECTORS = [
            'eyebrows'  => ["div.eyebrow:first-child"],
            'headlines' => ['h1:first-child','h2:first-child','h3:first-child'],
            'intros'    => ['p:first-child'],
            'kickers'   => ["p:last-child"],
            'actions'   => ["p[data-only-links]:last-child"],
        ];


        const PARTS =  [
            'eyebrows'  => [],   'eyebrow'   => null,
            'headlines' => [],   'headline'  => null,
            'intros'    => [],   'intro'     => null,
            'kickers'   => [],   'kicker'    => null,
            'actions'   => [],   'action'    => null,
            'body'      => null,
        ];


        public function getFunctions(): array {
            return [
                new TwigFunction( 'TextBase', [$this, 'TextBase'] ),
                new TwigFunction( 'textbase', [$this, 'TextBase'] ),
            ];
        }


        public function TextBase( mixed $html = "" ): array
        {
            if( is_array( $html ) ) { return $html; }

            // TODO: Making Caching configurable
            $cacheKey  =  "TextBase-" . md5($html);
            $textparts = \Craft::$app->cache->getOrSet( $cacheKey, function () use ($html) {

                $textparts = self::PARTS;
                if( empty( trim( $html ) ) ) { return $textparts; }

                // process the top level DomElements in the rich html string for:
                // - replace style="text-align:left|center|right" attriutes with class names
                // - paragraphs that contain one or more buttons
                $html = $this->_blockelements( $html );


                // collect all the parts
                $selectors = self::SELECTORS;
                foreach( $selectors as $key => $selector ) {
                    foreach( $selector as $s ) {
                        if( $match = $this->_retconOnly( $html, $s ) ) {
                            $textparts[$key][] = $match;
                            $html = $this->_retconRemove( $html, $s );
                        }
                    }

                    // singularize the parts into a joined string
                    $single = rtrim($key,'s');
                    $textparts[$single] = join( "\n", $textparts[$key] );
                }

                $textparts['body'] = $html;

                return $textparts;

            }, 86400 );

            return $textparts;
        }


        private function _blockelements( $html ) {

            // <a data-href="..."> ➔ <a href="..." data-href="...">
            // give all <a> tags a data-href attribute that matches the value of their current
            // href attribute, making it easier and more accessible to target with JS/CSS
            $html = (string) Retcon::getInstance()->retcon->renameAttr( $html, "a", [ 'href' => 'data-href' ] );
            $html = preg_replace('/data-href="(.*?)"/', "href=\"$1\" data-href=\"$1\"", $html );

            // <a data-only-link>...</a>
            // if only one link exists in the string, give it a data-only-link attribute to make it
            // targetable with JS/CSS so that it may be styled or treated differently.
            if( mb_substr_count( mb_strtolower( $html ), "</a>" ) == 1 && !mb_substr_count( mb_strtolower( $html ), "<button" ) ) {
                $html = (string) Retcon::getInstance()->retcon->attr( $html, "a", [ "data-only-link" => true ] );
            }

            // any top level blocks elements in the html string?
            // <p> <h2> <blockquote> <ul>, etc
            if( $domnodes = $this->_html2nodes( $html ) ) {

                // loop through them
                $html = "";
                foreach( $domnodes AS $node ) {
                    if(!$node) { continue; }

                    // style="text-align:center;" ➔ class="text-center"
                    $node = $this->_realign( $node );

                    // handle each type of block element
                    $tagname = mb_strtolower( $node->tagName ?? "" );
                    switch( $tagname ) {
                        case 'p':
                            $html .= $this->_paragraph( $node );
                            break;
                        case 'ol':
                            $html .= $this->_list( $node );
                            break;
                        case 'ul':
                            $html .= $this->_list( $node );
                            break;
                        case 'blockquote':
                            $html .= $this->_blockquote( $node );
                            break;
                        case 'div':
                            $html .= $this->_div( $node );
                            break;
                        case 'figure':
                            $html .= $this->_figure( $node );
                            break;
                        default:
                            $html .= $node->ownerDocument->saveHTML($node);
                    }
                }
            }

            return $html;
        }



        // <p style="text-align:center;"> ➔ <p class="text-center">
        // <p style="text-align : left ; fizz:buzz"> ➔ <p class="text-left" style="fizz:buzz;">
        // ...etc for text-right / text-justify
        private function _realign( $node ) {
            $class = $node->getAttribute('class') ?? "";
            $style = mb_strtolower( mb_ereg_replace( ' ', '', $node->getAttribute('style') ?? "" ) );
            $style.= empty($style) || str_ends_with( $style, ';' ) ? '' : ';';

            if( !empty($style) ) {

                if( strstr( $style, "text-align:left;" ) ) {
                    $style = mb_ereg_replace('text-align:left;', '', $style);
                    $class.= " text-left";
                }

                if( strstr( $style, "text-align:center;" ) ) {
                    $style = mb_ereg_replace('text-align:center;', '', $style);
                    $class.= " text-center";
                }

                if( strstr( $style, "text-align:right;" ) ) {
                    $style = mb_ereg_replace('text-align:right;', '', $style);
                    $class.= " text-right";
                }

                if( strstr( $style, "text-align:justify;" ) ) {
                    $style = mb_ereg_replace('text-align:justify;', '', $style);
                    $class.= " text-justify";
                }

                $class = trim( $class );
                if( $class ) { $node->setAttribute( "class", $class ); }

                $style = trim( $style );
                if( $style ) { $node->setAttribute( "style", $style ); }
                else { $node->removeAttribute( "style" ); }
            }

            return $node;
        }


        // paragraph tag adjustments: <p>
        // mostly just identifying paragraphs with links and/or only links/buttons in them
        private function _paragraph( $node ) {
            $paragraph = $node->ownerDocument->saveHTML( $node );

            if( $this->_retconOnly( $paragraph, "span.text-big" ) ) {
                $paragraph = $this->_retconChange( $paragraph, 'span.text-big', false );
                $paragraph = $this->_retconAttr( $paragraph, 'p', [ 'class' => 'large' ], false );
            }

            if( $this->_retconOnly( $paragraph, "span.text-small" ) ) {
                $paragraph = $this->_retconChange( $paragraph, 'span.text-small', false );
                $paragraph = $this->_retconAttr( $paragraph, 'p', [ 'class' => 'small' ], false );
            }

            // <p data-only-links><a href="#">...</a></p>
            // <p data-has-link>... <a href="#">...</a> ...</p>
            $selector = 'a,button';
            $links = $this->_retconOnly( $paragraph, $selector );
            if( $links ) {
                $leftover = $this->_retconRemove( $paragraph, 'a,button' );
                $leftover = (string) Retcon::getInstance()->retcon->change( $leftover, 'p', false );

                $leftover = trim( $leftover );
                $leftover = preg_replace('/&nbsp;/', ' ', $leftover);
                $leftover = preg_replace('/<br>\s*$/', '', $leftover);
                $leftover = preg_replace('/<br\s*\/>\s*$/', '', $leftover);
                $leftover = trim( $leftover );

                if( empty( $leftover ) ) {
                    $paragraph = (string) Retcon::getInstance()->retcon->attr( $paragraph, 'p', ['data-only-links' => true] );
                } else {
                    $paragraph = (string) Retcon::getInstance()->retcon->attr( $paragraph, 'p', ['data-has-link' => true] );
                }
            }

            $paragraph = trim( $paragraph );
            $paragraph = preg_replace('/&nbsp;/', ' ', $paragraph);
            $paragraph = preg_replace('/<br>\s*$/', '', $paragraph);
            $paragraph = preg_replace('/<br\s*\/>\s*$/', '', $paragraph);

            return $paragraph;
        }


        // saving these for later
        private function _list( $node )       { return $node->ownerDocument->saveHTML( $node ); }
        private function _blockquote( $node ) { return $node->ownerDocument->saveHTML( $node ); }
        private function _div( $node )        { return $node->ownerDocument->saveHTML( $node ); }
        private function _figure( $node )     { return $node->ownerDocument->saveHTML( $node ); }


        // shorthand for calling Retcon::getInstance()->retcon->only()
        private function _retconOnly( $html, $selector ) {
            $html = (string) Retcon::getInstance()->retcon->only( "<template>$html</template>", "template $selector" ) ?? null;
            return trim( $html );
        }


        // shorthand for calling Retcon::getInstance()->retcon->attr()
        private function _retconAttr( $html, $selector, $attr, $overwrite = true ) {
            $html = (string) Retcon::getInstance()->retcon->attr( $html, $selector, $attr, $overwrite ) ?? null;
            return trim( $html );
        }


        // shorthand for calling Retcon::getInstance()->retcon->attr()
        private function _retconChange( $html, $selector, $attr ) {
            $html = (string) Retcon::getInstance()->retcon->change( $html, $selector, $attr ) ?? null;
            return trim( $html );
        }


        // shorthand for calling Retcon::getInstance()->retcon->remove()
        private function _retconRemove( $html, $selector ) {
            $html = (string) Retcon::getInstance()->retcon->remove( "<template>$html</template>", "template $selector" );
            $html = (string) Retcon::getInstance()->retcon->change( $html, "template", false );
            return trim( $html );
        }


        // convert a string of html into a collection of DomNodes using Symfony\Component\DomCrawler\Crawler
        // https://symfony.com/doc/current/components/dom_crawler.html
        // https://github.com/symfony/dom-crawler
        private function _html2nodes( $html ) {
            $html = \mb_convert_encoding($html, 'HTML-ENTITIES', Craft::$app->getView()->getTwig()->getCharset());
            if( mb_substr($html,0,1) != '<' ) { return null; }
            $libxmlerrors = \libxml_use_internal_errors(true);
            $doc = new \DOMDocument();
            $doc->loadHTML("<template>$html</template>", LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
            \libxml_use_internal_errors($libxmlerrors);
            $crawler = new \Symfony\Component\DomCrawler\Crawler($doc);
            return $crawler->filter('template')->children();
        }
    }