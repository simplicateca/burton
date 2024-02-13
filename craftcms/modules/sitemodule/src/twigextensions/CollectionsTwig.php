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
use GuzzleHttp;
use craft\elements\Entry;

class CollectionsTwig extends AbstractExtension
{

    public function getFunctions(): array
    {
        return [
            new TwigFunction( 'collectionLookup',   [$this, 'collectionLookup'] ),
            new TwigFunction( 'collectionContents', [$this, 'collectionContents'] ),
        ];
    }


    public function collectionLookup( $feedID, $searchParams ): mixed
    {
        // Get the feeds entry
        $feeds = Entry::find()->section('taxonomy')->id( $feedID )->fixedOrder(true) ?? null;
        $firstFeed = $feeds->one() ?? null;

        // Collect query parameters
        $filter = Craft::$app->request->getParam('f') ?? $searchParams['filter'] ?? $firstFeed->slug ?? null;
        $query  = Craft::$app->request->getParam('q') ?? $searchParams['query']  ?? null;

        // Get the search entry
        $search = $firstFeed ?? null;
        $search = $feeds->collect()->firstWhere('slug', $filter) ?? $firstFeed ?? null;

        // Get content type, section, and entry type
        $contentSource = $search->contentSource ? $search->contentSource->proto() : null;
        $section       = $contentSource ? ( $contentSource['section']   ?? null ) : null;
        $entryType     = $contentSource ? ( $contentSource['entryType'] ?? null ) : null;

        // parse an rss feed
        if( $contentSource['value'] ?? null == 'rss' && $search->sourceUrl ) {
            $this->parseRSS( $search->sourceUrl, $searchParams['limit'] ?? null );
        }

        // prepare a Craft query based on the content feed settings
        else
        {
            // Get sort, redirect, and topics
            $sort     = $search ? $search->sort->value : null;
            $topics   = $search ? $search->taxonomies->all() : null;

            // Set search/sort/filter settings
            $orderBy = 'postDate DESC';
            $orderBy = $sort == 'random' ? 'RAND()' : $orderBy;
            $orderBy = $sort == 'alphabetical' ? 'title DESC' : $orderBy;
            $orderBy = $sort == 'upcoming' ? 'startDate ASC' : $orderBy;

            // Create the starting query
            $collectionQuery = null;
            if ($section == 'products') {
                $collectionQuery = Entry::find()->section('products')->availableForPurchase(true);
                $orderBy = $sort == 'recent' ? 'dateUpdated DESC' : $orderBy;
            } else {
                $collectionQuery = Entry::find();
                $collectionQuery = $section ? $collectionQuery->section($section) : $collectionQuery;
            }

            if ($query) {
                $collectionQuery = $collectionQuery->search($query);
                $orderBy = 'score';
            }

            $limit = $searchParams['limit'] ?? -1;
            $collectionQuery = $collectionQuery->orderBy($orderBy)->limit( $limit );

            if( $entryType ) {
                $collectionQuery = $collectionQuery->type( $entryType );
            } else {
                $collectionQuery = $collectionQuery->type(['not', 'dynamic', 'static', 'rss', 'private', 'redirect', 'bodyFragment', 'sidebarFragment']);
            }

            if( $topics ) {
                $collectionQuery = $collectionQuery->relatedTo( $topics );
            }

            return $collectionQuery;
        }
    }


    public function collectionContents( $feedID, $searchParams ): Array
    {
        $feedQueryOrResults = $this->collectionLookup( $feedID, $searchParams );

        return is_array( $feedQueryOrResults )
            ? $feedQueryOrResults ?? []
            : $feedQueryOrResults->all() ?? [];
    }


    private function parseRSS( $feedUrl = null, $limit = -1 ) : Array
    {
        // parse an rss feed using Guzzle
        // keep the feed results cached for 24 hours
        $xmlString = \Craft::$app->cache->getOrSet( "rss-$feedUrl-$limit", function () use ($feedUrl) {
            $client = new GuzzleHttp\Client();
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