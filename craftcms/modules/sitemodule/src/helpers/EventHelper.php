<?php

namespace modules\sitemodule\helpers;

use craft\events\ModelEvent;
use verbb\events\elements\Event as EventElement;
use yii\base\Event;

class EventHelper
{
    // Setup Event Listeners
    // https://verbb.io/craft-plugins/events/docs/developers/events
    public static function listeners() {

        // EVENT_BEFORE_SAVE
        // Set the slug to the Internal Code (i.e. LT24, LWO25, etc.)
        // https://verbb.io/craft-plugins/events/docs/developers/events#the-beforeSaveEvent-event
        // Event::on(EventElement::class, EventElement::EVENT_BEFORE_SAVE, function(ModelEvent $event) {
        //     $eventElement = $event->sender;
        //     $eventElement->slug = $eventElement->code;
        // });

    }
}