<?php
/**
 * CCollection Processing Macro
 *
 * Used to lookup the contents of Collection entries, including static and RSS feeds.
 *
 * There's nothing in here that you can't do directly in Twig (except maybe the RSS feed?).
 * However, it's a lot cleaner and more reusable as an external Twig macro.
 *
 */

namespace modules\sitemodule\twigextensions;

use Craft;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;
use mmikkel\retcon\Retcon;

class CollectionBaseTwig extends AbstractExtension
{
    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'CollectionBase', [ $this, 'CollectionBase' ] ),
            new TwigFunction( 'collectionbase', [ $this, 'CollectionBase' ] ),
        ];
    }


    public function CollectionBase( $onlyIDs, $params ) {

        // Get the selected Collection (or the first one if we're not filtering by collection)
        $collection = Craft::configure( \craft\elements\Entry::find(), array_filter([
            'section'    => 'collections',
            'id'         => is_array( $onlyIDs ) ? $onlyIDs : $onlyIDs->all() ?? [],
            'slug'       => Craft::$app->request->getParam('f') ?? $params['filter'] ?? null,
            'fixedOrder' => true,
        ]) )->one() ?? null;

        if( !$collection ) { return []; }

        $collectiontype = (string) $collection->type->handle ?? 'static';

        switch ( strtolower( $collectiontype ) ) {
            case 'rss':
                return $this->processRSS( $collection, $params );
                break;
            case 'dynamic':
                return $this->processDynamic( $collection, $params );
                break;
            default:
                return $this->processStatic( $collection, $params );
        }
    }



    public function processStatic( $collection, $params ) : Array
    {
        $field = $params['field'] ?? 'entries';
        $limit = $params['limit'] ?? -1;

        if( $field == 'entries' ) {
            return $collection->entries->limit( $limit )->all() ?? [];
        }

        if( $field == 'assets' ) {
            return $collection->assets->limit( $limit )->all() ?? [];
        }

        if( $field == 'images' ) {
            return $collection->images->limit( $limit )->all() ?? [];
        }

        return [];
    }



    ## TODO: I am positive that I wrote a better version of this function in a
    ## different test projects, but I can't seem to find it, so for now this will do.
    public function processDynamic( $collection, $params ) : Mixed
    {
        $query = [
            'limit'   => $params['limit'] ?? -1,
            'order'   => $collection->sort->settings['order'] ?? 'postDate DESC',
            'where'   => $collection->contentSource->settings['whereQuery'] ?? null,
            'search'  => Craft::$app->request->getParam('q') ?? $params['query'] ?? null,
        ];

        $elementType  = (string) $collection->contentSource->settings['elementType'] ?? 'entry';
        $elementQuery = null;
        switch ( strtolower( $elementType ) ) {
            case 'product':
                $elementQuery = \craft\commerce\elements\Product::find()->availableForPurchase(true);
                break;
            case 'verbbevent':
                $elementQuery = \verbb\events\elements\Event::find();
                break;
            case 'asset':
                $elementQuery = \craft\elements\Asset::find();
                break;
            default:
                $elementQuery = \craft\elements\Entry::find();
        }

        if( $query['search'] ) {
            $elementQuery->search( $query['search'] );
            $query['order'] = 'score';
        }

        if( $taxonomies = $collection->taxonomies->exists() ? $collection->taxonomies->ids() : [] ) {
            $elementQuery->relatedTo( $taxonomies );
        }

        if( $query['where'] && $query['where']['section'] ?? null ) {
            $section = $query['where']['section'];
            unset( $query['where']['section'] );
            $elementQuery->section( $section );
        }

        if( $query['where'] && $query['where']['type'] ?? null ) {
            $entrytype = $query['where']['type'];
            unset( $query['where']['type'] );
            $elementQuery->type( $entrytype );
        }

        if( !empty( $query['where'] ) ) {
            $elementQuery->where( $query['where'] );
        }

        $elementQuery->limit( $query['limit'] );
        $elementQuery->orderBy( $query['order'] );

        $returnObject = $params['return'] ?? 'results';
        if( $returnObject  == 'query' ) {
            return $elementQuery;
        } else {
            return $elementQuery->one() ? $elementQuery->all() : [];
        }
    }



    public function processRSS( $collection, $params ) : Array
    {
        $feedUrl = $collection->sourceUrl ?? null;
        if( !$feedUrl ) { return []; }

        $limit = $params['limit'] && $params['limit'] > 0 ? $params['limit'] : 25;

        return $this->_feedContent( $feedUrl, $limit ) ?? [];
    }



    private function _feedContent( $feedUrl = null, $limit = 25 ) : Array
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
                'url'         => (string) $i->link  ?? null,
                'text'        => (string) $i->content ?? null,
                'date'        => (string) $i->pubDate,
                'uuid'        => (string) $i->guid,
                'summary'     => (string) $i->description ?? null,
                'headline'    => (string) $i->title ?? null,

                'enclosure'   => (string) $i->enclosure->attributes()->url ?? null,

                'section'     => 'rss',
                'type'        => 'rssitem',
            ];

            $item['images']   = $item['enclosure'] ?? Retcon::getInstance()->retcon->only( $item['summary'] . $item['text'], 'img' );

            $item['summary']  = strip_tags( $item['summary'] );
            $item['headline'] = strip_tags( $item['headline'] );

            $items[] = $item;

            if( $limit >= 1 && count( $items ) >= $limit ) { break; }
        }

        return $items;
    }
}
