<?php

namespace modules\sitemodule\widgets;

use Craft;
use craft\base\Widget;

class SitehubWidget extends Widget
{
    // Properties
    // =========================================================================

    //public $someProperty;

    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public static function displayName(): string
    {
        return Craft::t('site-module', 'Sitehub Widget');
    }

    /**
     * @inheritdoc
     */
    public function getTitle(): string
    {
        return Craft::t('site-module', 'Visit Your Sitehub');
    }

    /**
     * @inheritdoc
     */
    public function getBodyHtml(): ?string
    {
        // Render the widget body template
        return Craft::$app->getView()->renderTemplate(
            'site-module/sitehub-widget-body',
            [
                //'someProperty' => $this->someProperty,
            ]
        );
    }
}