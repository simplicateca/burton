<?php
/**
 * Collection Processing Macro
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
use Illuminate\Support\Collection;

class CollectionBaseTwig extends AbstractExtension
{
    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'CollectionBase', [ $this, 'CollectionBase' ] ),
            new TwigFunction( 'collectionbase', [ $this, 'CollectionBase' ] ),
        ];
    }


    private function elementQuery( $type ) {
        switch ( strtolower( $type ?? 'entry' ) ) {
            case 'product':
                return \craft\commerce\elements\Product::find()->availableForPurchase(true);
            case 'verbbevent':
                return  \verbb\events\elements\Event::find();
            case 'asset':
                return  \craft\elements\Asset::find();
            default:
                return  \craft\elements\Entry::find();
        }
    }



    public function CollectionBase( $collections, $params )
    {
        // We might get passed a list of Collection IDs to choose from, but since
        // we can only load entries from one collection at a time,
        // Regardless,
        // so we need to figure out which one to use
        $collection = null;
        $isJustIds  = $this->justids( $collections );

        // If were were given a list of (at least one) Collection ID to use...
        if( $isJustIds )
        {
            $query = [
                'section'    => 'collections',
                'id'         => $collections,
                'fixedOrder' => true,
            ];

            // Do we need to filter by slug?
            // Happens if we have an array of colletions and we're toggling between them
            if( $params['slug'] ?? null ) {
                $query['slug'] = $params['slug'];
            }

            // Get the selected Collection (or the first one if we're not filtering by collection)
            $collection = Craft::configure( \craft\elements\Entry::find(), $query )->one() ?? null;
        }

        // were we given a Collection Element?
        if( is_object($collections) && $collections->one() ) {

            // Do we need to filter by slug?
            if( $params['slug'] ?? null ) {
                $collections = $collection->slug($params['slug']);
            }

            $collection = $collections->one();
        }

        // Are we creating a collection on the fly?
        if( !$isJustIds && !$collection && is_array( $collections ) )
        {
            if( $collections['where'] ?? null ) {
                return $this->processManual( $collections, $params );
            }
        }

        if( !$collection ) { return []; }

        $collectiontype = (string) $collection->type->handle ?? 'manual';

        switch ( strtolower( $collectiontype ) ) {
            case 'rss':
                return $this->processRSS( $collection, $params );
                break;
            case 'dynamic':
                return $this->processDynamic( $collection, $params );
                break;
            case 'static':
                return $this->processStatic( $collection, $params );
                break;
            default:

        }
    }



    public function processManual( $fly, $params ) : Mixed
    {
        $query = [
            'where'   => $fly['where'] ?? null,
            'with'    => $fly['with']  ?? null,
            'order'   => $fly['order'] ?? $params['order'] ?? 'postDate DESC',
            'limit'   => $fly['limit'] ?? $params['limit'] ?? -1,
            'search'  => $fly['query'] ?? $params['query'] ?? null
        ];

        $elementQuery = $this->elementQuery( $fly['element'] ?? 'entry' );

        if( $query['search'] ) {
            $elementQuery->search( $query['search'] );
            $query['order'] = 'score';
        }

        if( $fly['relatedTo'] ?? null ) {
            $elementQuery->relatedTo( $fly['relatedTo'] );
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

        if( !empty( $query['with'] ) ) {
            $elementQuery->with( $query['with'] );
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



    public function processStatic( $collection, $params ) : Mixed
    {
        $field = $params['field'] ?? 'entries';
        $limit = $params['limit'] ?? -1;

        if( $field == 'entries' ) {
            return $collection->entries->limit( $limit )->all() ?? [];
        }

        if( $field == 'media' ) {
            return $collection->media->limit( $limit )->all() ?? [];
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
            'where'   => $collection->contentSource->settings['where'] ?? null,
            'with'    => $collection->contentSource->settings['with']  ?? null,
            'search'  => $params['query'] ?? null
        ];

        $elementQuery = $this->elementQuery(
            (string) $collection->contentSource->settings['element'] ?? 'entry'
        );


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

        if( !empty( $query['with'] ) ) {
            $elementQuery->with( $query['with'] );
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


    private function justids( $collections ) {
        $array = Collection::make($collections)->toArray();
        return array_filter($array, 'is_numeric') === $array;
    }
}
