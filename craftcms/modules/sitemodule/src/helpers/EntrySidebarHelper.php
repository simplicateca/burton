<?php

namespace modules\sitemodule\helpers;

use Craft;
use yii\base\Event;
use craft\elements\Entry;
use craft\events\RegisterElementSourcesEvent;

class EntrySidebarHelper
{
    // Enable Sitehub Functionality
    public static function enable()
    {
        Event::on(Entry::class, Entry::EVENT_REGISTER_SOURCES, function(RegisterElementSourcesEvent $event) {

            if( $event->context == 'modal' ) { return $event->sources; }

            $newSources = [];
            foreach ( $event->sources as &$source ) {

                $sectionType  = $source['data']['type'] ?? null;
                $sectionId    = $source['criteria']['sectionId'] ?? null;

                if( !is_int( $sectionId ) ) {
                    $newSources[] = $source;
                    continue;
                }

                $entrytypes = Craft::$app->sections->getEntryTypesBySectionId( $sectionId );

                if( count($entrytypes) < 2 || $sectionType != 'channel' ) {
                    $newSources[] = $source;
                    continue;
                }

                $children = [];
                foreach( $entrytypes AS $type ) {

                    $typeSource = [
                        'type'  => 'custom',
                        'label' => $type->name,
                        'key'   => $source['key'] . ':' . $type->handle,
                        'data'  => [
                            'handle'     => $type->section->handle,
                            'entry-type' => $type->handle,
                        ],
                        'criteria' => [
                            'sectionId' => $source['criteria']['sectionId'] ?? null,
                            'editable'  => $source['criteria']['editable'] ?? null,
                            'typeId'    => $type->id,
                        ],
                        'condition' => [
                            'class' => 'craft\elements\conditions\entries\EntryCondition',
                            'conditionRules' => [[
                                'class'    => 'craft\elements\conditions\entries\SectionConditionRule',
                                'operator' => 'in',
                                'uid'      => '',
                                'values'   => [$type->section->uid] ?? null
                            ],[
                                'class'    => 'craft\elements\conditions\entries\TypeConditionRule',
                                'operator' => 'in',
                                'uid'      => '',
                                'values'   => [$type->uid] ?? null
                            ]],
                        ],
                        'elementType'     => 'craft\elements\Entry',
                        'fieldContext'    => 'global',
                        'defaultSort'     => $source['defaultSort'] ?? null,
                        'tableAttributes' => $source['tableAttributes'] ?? null,
                    ];

                    $children[] = $typeSource;
                }

                if( !empty( $children ) ) {
                    $source['nested'] = $children;
                }

                $newSources[] = $source;
            }

            $event->sources = $newSources;
        });
    }
}