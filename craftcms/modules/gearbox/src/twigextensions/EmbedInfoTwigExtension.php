<?php
/**
 * Gearbox - Collections Twig Extension
 *
 * Used to lookup the contents of Collection entries, including static and RSS feeds.
 *
 */

namespace modules\gearbox\twigextensions;

use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;
use mmikkel\retcon\Retcon;
use Embed\Embed;

class EmbedInfoTwigExtension extends AbstractExtension
{

    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'embedInfo', [ $this, 'embedInfo' ]),
        ];
    }


    public function embedInfo( $url )
    {
        $embedData = \Craft::$app->cache->getOrSet( "oembed2-$url", function () use ($url) {
            $embed = new Embed();
            $info = $embed->get($url);

            $data = [
                'title'       => $info->title,
                'summary'     => $info->description,
                'url'         => (string) $info->url,
                'images'      => [ ['url' => (string) $info->image] ],
                'html'        => $info->code->html,
                'ratio'       => $info->code->ratio,
                'aspect'      => "",
                'provider'    => mb_strtolower( $info->providerName ),
                'authorName'  => $info->authorName ?? null,
                'authorUrl'   => $info->authorUrl  ?? null,
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

}