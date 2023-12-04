<?php

namespace modules\sitemodule\widgets;

use Craft;
use craft\base\Widget;

class SitebookWidget extends Widget
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
        return Craft::t('site-module', 'Sitebook Widget');
    }

    /**
     * @inheritdoc
     */
    public function getTitle(): string
    {
        return Craft::t('site-module', 'Visit Your Sitebook');
    }

    /**
     * @inheritdoc
     */
    public function getBodyHtml(): ?string
    {
        // Render the widget body template
        return Craft::$app->getView()->renderTemplate(
            'site-module/_components/sitebook-widget-body',
            [
                //'someProperty' => $this->someProperty,
            ]
        );
    }
}