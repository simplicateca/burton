<?php

namespace modules\sitemodule\helpers;

use yii\base\Event;
use craft\redactor\Field AS RedactorField;

class HtmlTextHelper
{
    public static function enable()
    {
        // self::purifierConfig();
    }


    // Allow new attributes (needed by Link Attribute Redactor plugin)
    private static function purifierConfig()
    {
        Event::on(
            RedactorField::class,
            RedactorField::EVENT_MODIFY_PURIFIER_CONFIG,
            function (Event $event) {
                if( $event->config ) {
                    if( $def = $event->config->getDefinition('HTML', true) ) {
                        $def->addAttribute('a', 'aria-label', 'Text');
                        $def->addAttribute('a', 'data-ident', 'Text');
                        $def->addAttribute('a', 'data-modal', 'Bool');
                    }
                }
            }
        );
    }
}