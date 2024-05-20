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

            new TwigFunction( 'CollectionResults', [ $this, 'CollectionResults' ] ),
            new TwigFunction( 'collectionresults', [ $this, 'CollectionResults' ] ),
        ];
    }


    private function elementQuery( $type ) {
        $type = trim( strtolower( (string) $type ) );
        $type = $type ? $type : 'entry';
        switch ( $type ) {
            case 'product':
                return \craft\commerce\elements\Product::find()->availableForPurchase(true);
            case 'verbbevent':
                return  \verbb\events\elements\Event::find();
            case 'asset':
                return \craft\elements\Asset::find();
            default:
                return \craft\elements\Entry::find();
        }
    }


    public function CollectionResults( $collections, $params )
    {
        $results = $this->CollectionBase( $collections, $params );
        return ( is_object( $results ) &&  $results->one() )
            ? $results->all()
            : $results;
    }


    public function CollectionBase( $collections, $params )
    {
        if( $collections == null || empty( $collections ) ) { return []; }
        $collection = null;

        // First, we need to figure out what the $collections argument contains.

        // Option 1
        // A list of Collection IDs (probably came through Sprig)
        if( $this->isOnlyIDs( $collections ) ) {
            $query = [
                'section'    => 'collections',
                'id'         => $collections,
                'fixedOrder' => true,
            ];

            // Do we need to filter by slug?
            // Happens if we have an array of colletions and we're toggling between them
            if( $params['filter'] ?? null ) {
                $query['slug'] = $params['filter'];
            }

            // Get the selected Collection (or the first one if we're not filtering by collection)
            $collection = Craft::configure( \craft\elements\Entry::find(), $query )->one() ?? null;
        }

        // Option 2
        // ElementQuery of Collection entries, i.e. the "Collections" Entries field
        // -> https://docs.craftcms.com/api/v5/craft-elements-db-elementquery.html#elementquery
        // -> https://craftcms.com/docs/5.x/reference/field-types/entries.html
        if( is_object($collections) && $collections->one() ) {

            // Do we need to filter by slug?
            if( $params['filter'] ?? null ) {
                $collection = $collections->firstWhere( 'slug', $params['filter'] ) ?? null;
            }

            $collection = $collection ? $collection : $collections->first() ?? null;

            if( is_array( $collection ) && isset( $collection['where'] ) ) {
                return $this->processManual( $collection, $params );
            }
        }

        // Option 3
        // An ElementQuery search description built on the fly in twig?
        if( !$collection && is_array( $collections ) && isset( $collections['where'] ) )
        {
            return $this->processManual( $collections, $params );
        }

        // Option 4
        // An Array of Collections (probably an eager loaded version of option 2)?
        if( !$collection && is_array( $collections ) )
        {
            $collection = $collections[0];
        }

        // If we still don't have a collection, we can't do anything.
        if( !$collection ) { return []; }

        // But if we do have a collection, we can process it based on its type
        switch ( strtolower( $collection->type->handle ) ) {
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
                return null;
        }
    }



    // TODO: processManual() and processDynamic() are almost identical, and should be refactored
    public function processManual( $fly, $params ) : Mixed
    {
        $query = [
            'where'   => $fly['where']   ?? null,
            'with'    => $fly['with']    ?? null,
            'orderBy' => $fly['orderBy'] ?? $params['orderBy'] ?? $fly['order'] ?? $params['order'] ?? 'postDate DESC',
            'limit'   => $fly['limit']   ?? $params['limit'] ?? 100,
            'keyword' => $fly['query']   ?? $params['query'] ?? null,
            'before'  => $fly['before']  ?? null,
            'after'   => $fly['after']   ?? null,
        ];

        $elementQuery = $this->elementQuery( $fly['element'] ?? 'entry' );

        if( $query['keyword'] ) {
            $elementQuery->search( $query['keyword'] );
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

        $postdate = [];
        if( $query['before'] ) {
            $postdate[] = "<= " . date( 'Y-m-d', strtotime( $query['before'] ) );
        }

        if( $query['after'] ) {
            $postdate[] = ">= " . date( 'Y-m-d', strtotime( $query['after'] ) );
        }

        if( count( $postdate ) ) {
            $elementQuery->postDate( count( $postdate ) == 2
                ? [ 'and', $postdate[0], $postdate[1] ]
                : $postdate[0]
            );
        }

        $elementQuery->limit( $query['limit'] );
        $elementQuery->orderBy( $query['orderBy'] );

        return $elementQuery;
    }



    public function processStatic( $collection, $params ) : Mixed
    {
        $staticfield = $params['static'] ?? 'entries';
        $limit = $params['limit']  ?? 100;

        if( $staticfield == 'entries' ) {
            return $collection->entries->limit($limit) ?? null;
        }

        if( $staticfield == 'media' ) {
            return $collection->media->limit($limit) ?? null;
        }

        if( $staticfield == 'images' ) {
            return $collection->images->limit($limit) ?? null;
        }

        return null;
    }



    ## TODO: I am positive that I wrote a better version of this function in a
    ## different test projects, but I can't seem to find it, so for now this will do.
    public function processDynamic( $collection, $params ) : Mixed
    {
        $query = [
            'element' => $collection->source->settings['element'] ?? 'entry',
            'where'   => $collection->source->settings['where'] ?? null,
            'with'    => $collection->source->settings['with']  ?? null,
            'orderBy' => $collection->source->settings['orderBy'] ?? $collection->source->settings['order'] ?? 'postDate DESC',
            'limit'   => $params['limit'] ?? 100,
            'keyword' => $params['query'] ?? null,
            'before'  => $collection->source->settings['before'] ?? null,
            'after'   => $collection->source->settings['after'] ?? null,
        ];

        $elementQuery = $this->elementQuery( $query['element'] );

        if( $query['keyword'] ) {
            $elementQuery->search( $query['keyword'] );
            $query['order'] = 'score';
        }

        if( $taxonomies = $collection->taxonomies->exists() ? $collection->taxonomies->ids() : [] ) {
            $elementQuery->relatedTo( $taxonomies );
        }

        if( $users = $collection->taxonomies->exists() ? $collection->taxonomies->ids() : [] ) {
            $elementQuery->relatedTo( $taxonomies );
        }

        if( isset( $query['where'] ) && !empty( $query['where'] ) ) {

            if( $query['where'] && isset( $query['where']['section'] ) ) {
                $section = $query['where']['section'];
                unset( $query['where']['section'] );
                $elementQuery->section( $section );
            }

            if( $query['where'] && isset( $query['where']['type'] ) ) {
                $entrytype = $query['where']['type'];
                unset( $query['where']['type'] );
                $elementQuery->type( $entrytype );
            }

            if( !empty( $query['where'] ) ) {
                $elementQuery->where( $query['where'] );
            }
        }

        if( !empty( $query['with'] ) ) {
            $elementQuery->with( $query['with'] );
        }

        $postdate = [];
        if( $query['before'] ) {
            $postdate[] = "<= " . date( 'Y-m-d', strtotime( $query['before'] ) );
        }

        if( $query['after'] ) {
            $postdate[] = ">= " . date( 'Y-m-d', strtotime( $query['after'] ) );
        }

        if( count( $postdate ) ) {
            $elementQuery->postDate( count( $postdate ) == 2
                ? [ 'and', $postdate[0], $postdate[1] ]
                : $postdate[0]
            );
        }

        $elementQuery->limit( $query['limit'] );
        $elementQuery->orderBy( $query['orderBy'] );

        return $elementQuery;
    }



    public function processRSS( $collection, $params ) : Array
    {
        $feedUrl = $collection->website ?? null;
        if( !$feedUrl ) { return []; }

        return $this->_feedContent( $feedUrl, $params['limit'] ?? 10 ) ?? [];
    }



    private function _feedContent( $feedUrl = null, $limit = 10 ) : Array
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

            if( $limit >= 1 && count( $items ) >= $limit ) { return $items; }

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
        }

        return $items;
    }


    private function isOnlyIDs( $collections ) {
        $array = Collection::make($collections)->toArray();
        return ( count( $array ) && array_filter($array, 'is_numeric') === $array );
    }
}
