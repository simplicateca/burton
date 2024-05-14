<?php
/**
 * SiteModule - OEmbed URL Lookup Twig Extension
 *
 * Basically will query a URL to see if it return an oEmbed response
 * containing information about embeddable media available at the URL.
 *
 */

namespace modules\sitemodule\twigextensions;

use Craft;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;
use Embed\Embed;

class MediaBaseTwig extends AbstractExtension {

    public function getFunctions(): array {
        return [
            new TwigFunction( 'MediaBase', [ $this, 'MediaBase' ] ),
            new TwigFunction( 'mediabase', [ $this, 'MediaBase' ] ),
        ];
    }


    public function MediaBase( $url ) {
        $embedData = \Craft::$app->cache->getOrSet( "oembed-$url", function () use ($url) {
            $embed = new Embed();
            $info = $embed->get($url);

            $data = [
                'title'       => $info->title           ?? null,
                'summary'     => $info->description     ?? null,
                'url'         => (string) $info->url    ?? '',
                'images'      => [ ['url' => (string) $info->image ?? '' ] ],
                'html'        => $info->code->html      ?? null,
                'ratio'       => $info->code->ratio     ?? null,
                'provider'    => mb_strtolower( $info->providerName ?? null ),
                'authorName'  => $info->authorName ?? null,
                'authorUrl'   => $info->authorUrl  ?? null,
            ];

            return $data;

        }, 86400 );

        return $embedData;
    }
}