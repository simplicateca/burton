<?php
/**
 * Sitemodule - Collections Twig Extension
 *
 * Used to lookup the contents of Collection entries, including static and RSS feeds.
 *
 */

namespace modules\sitemodule\twigextensions;

use Craft;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;
use mmikkel\retcon\Retcon;

class CollectionsTwig extends AbstractExtension
{
    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'collectionLookup',   [ $this, 'collectionLookup'   ] ),
            new TwigFunction( 'collectionContents', [ $this, 'collectionContents' ] ),
        ];
    }


    public function collectionLookup( $onlyIDs, $params ) : mixed {

        // Get the selected Collection (or the first one if we're not filtering by collection)
        $collection = Craft::configure( \craft\elements\Entry::find(), array_filter([
            'section'    => 'collections',
            'id'         => is_array( $onlyIDs ) ? $onlyIDs : $onlyIDs->all() ?? [],
            'slug'       => Craft::$app->request->getParam('f') ?? $params['filter'] ?? null,
            'fixedOrder' => true,
        ]) )->one() ?? null;

        if( !$collection ) { return []; }

        if( $collection->type == 'static' ) {
            $field = $params['field'] ?? 'entries';
            $limit = $params['limit'] ?? -1;

            if( $field == 'entries' ) {
                return $collection->entries->limit( $limit )->all() ?? [];
            }

            if( $field == 'assets' ) {
                return $collection->assets->limit( $limit )->all() ?? [];
            }
        }


        if( $collection->type == 'dynamic' ) {

            $query = $collection->contentSource->whereQuery ?? [];
            $query['limit']   = $params['limit'] ?? -1;
            $query['orderBy'] = $collection->sort->order ?? 'postDate DESC';

            if( $keyword = Craft::$app->request->getParam('q') ?? $params['query'] ) {
                $query['search']  = $keyword;
                $query['orderBy'] = 'score';
            }

            if( $taxonomies = $collection->taxonomies->exists() ? $collection->taxonomies->ids() : [] ) {
                $search['relatedTo'] = $taxonomies;
            }


            $elementQuery = null;
            $elementType  = (string) $collection->contentSource->elementType ?? 'entry';
            switch ( strtolower( $elementType ) ) {
                case 'product':
                    $elementQuery = \craft\commerce\elements\Product::find()->availableForPurchase(true);
                    break;
                case 'asset':
                    $elementQuery = \craft\elements\Asset::find();
                    break;
                default:
                    $elementQuery = \craft\elements\Entry::find();
            }

            if( $elementQuery ) {
                $elementQuery = Craft::configure( $elementQuery, $query );
                return $elementQuery->all();
            }
        }

        if( $collection->type == 'rss' ) {
            return $this->parseRSS( $params['limit'] );
        }

        return [];
    }


    public function collectionContents( $onlyIDs, $params ): Array
    {
        $feedQueryOrResults = $this->collectionLookup( $onlyIDs, $params );

        return is_array( $feedQueryOrResults )
            ? $feedQueryOrResults ?? []
            : $feedQueryOrResults->all() ?? [];
    }


    private function parseRSS( $feedUrl = null, $limit = -1 ) : Array
    {
        // parse an rss feed using Guzzle
        // keep the feed results cached for 24 hours
        $xmlString = \Craft::$app->cache->getOrSet( "rss-$feedUrl-$limit", function () use ($feedUrl) {
            $client = new \GuzzleHttp\Client();
            $response = $client->get($feedUrl);
            return $response->getBody()->getContents();
        }, 86400 );

        // you cannot serialize `simplexml_load_string`, so we convert it after
        $feed = simplexml_load_string( $xmlString );

        $items = [];
        foreach( $feed->channel->item as $i ) {

            $item = [
                'headline'    => (string) $i->title,
                'url'         => (string) $i->link,
                'summary'     => (string) $i->description ?? (string) $i->content,
                'text'        => (string) $i->content ?? null,
                'topics'      => (array)  $i->category ?? [],
                'postDate'    => (string) $i->pubDate,
                'guid'        => (string) $i->guid,
                'section'     => 'rss',
                'type'        => $search->slug,
                'source'      => (string) $feed->channel->title,
            ];

            $item['image']   = $this->retconOnly( $item['summary'], 'img' );
            $item['summary'] = $this->retconRemove( $item['summary'], 'img' );
            $item['summary'] = $this->retconRemove( $item['summary'], 'figure' );
            $item['summary'] = Retcon::getInstance()->retcon->change( $item['summary'], "p", false );

            $item['topics']  = array_map(function ($a) { return (string) $a; }, $item['topics'] );

            $items[] = $item;
            if( $limit > 1 && count( $items ) >= $limit ) { break; }
        }

        return $items;
    }

}