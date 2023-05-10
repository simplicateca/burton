<?php
/**
 * Site module for Craft CMS 3.x
 *
 * Custom site module
 *
 * @link      https://simplicate.ca
 * @copyright Copyright (c) 2020 simplicate
 */

namespace modules\sitemodule;

use Craft;
use craft\web\View;

use yii\base\Module;
use yii\base\Event;
use yii\base\InvalidConfigException;

use craft\console\Application as ConsoleApplication;
use craft\events\TemplateEvent;
use craft\events\RegisterUrlRulesEvent;
use craft\events\RegisterTemplateRootsEvent;
use craft\i18n\PhpMessageSource;
use craft\redactor\Field AS RedactorField;
use craft\web\UrlManager;
use craft\web\twig\variables\CraftVariable;

use modules\sitemodule\assetbundles\sitemodule\SiteModuleAsset;
use modules\sitemodule\variables\SiteVariable;
use modules\sitemodule\twigextensions\SiteModuleTwigExtension;

class SiteModule extends Module
{
    public static SiteModule $instance;

    public function __construct($id, $parent = null, array $config = [])
    {
        Craft::setAlias('@modules/sitemodule', $this->getBasePath());
        $this->controllerNamespace = 'modules\sitemodule\controllers';

        // Translation category
        $i18n = Craft::$app->getI18n();
        /** @noinspection UnSafeIsSetOverArrayInspection */
        if (!isset($i18n->translations[$id]) && !isset($i18n->translations[$id.'*'])) {
            $i18n->translations[$id] = [
                'class' => PhpMessageSource::class,
                'sourceLanguage' => 'en-US',
                'basePath' => '@modules/sitemodule/translations',
                'forceTranslation' => true,
                'allowOverrides' => true,
            ];
        }


        // Base template directory
        Event::on(
            View::class,
            View::EVENT_REGISTER_CP_TEMPLATE_ROOTS,
            function (RegisterTemplateRootsEvent $e
        ) {
            if (is_dir($baseDir = $this->getBasePath().DIRECTORY_SEPARATOR.'templates')) {
                $e->roots[$this->id] = $baseDir;
            }
        });


        // Base template directory - site
        Event::on(View::class, View::EVENT_REGISTER_SITE_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) {
            $e->roots['_blocks']     = CRAFT_BASE_PATH . '/templates/_blocks';
            $e->roots['_components'] = CRAFT_BASE_PATH . '/templates/_components';
            $e->roots['_layouts']    = CRAFT_BASE_PATH . '/templates/_layouts';
            $e->roots['_macros']     = CRAFT_BASE_PATH . '/templates/_macros';
            $e->roots['_sections']   = CRAFT_BASE_PATH . '/templates/_sections';
            $e->roots['']            = CRAFT_BASE_PATH . '/templates/';
        });


        // Set this as the global instance of this module class
        static::setInstance($this);

        parent::__construct($id, $parent, $config);
    }


    /**
     * @inheritdoc
     */
    public function init(): void
    {
        parent::init();
        self::$instance = $this;

        // Add our TwigExtension(s)
        Craft::$app->view->registerTwigExtension(
            new SiteModuleTwigExtension()
        );

        // Register our Variables
        // Event::on(
        //     CraftVariable::class,
        //     CraftVariable::EVENT_INIT,
        //     function (Event $event) {
        //         /** @var CraftVariable $variable */
        //         $variable = $event->sender;
        //         $variable->set('site', SiteVariable::class);
        //     }
        // );


        // Register our frontend Controller Routes
        Event::on(
            UrlManager::class,
            UrlManager::EVENT_REGISTER_SITE_URL_RULES,
            function (RegisterUrlRulesEvent $event) {
                $event->rules['sitemodule-custom-route'] = 'site-module/default/index';
            }
        );


        // Register our Console Commands
        // if (Craft::$app instanceof ConsoleApplication) {
        //     $this->controllerNamespace = 'modules\sitemodule\console\controllers';
        // }


        // Load our AssetBundle
        // if (Craft::$app->getRequest()->getIsCpRequest()) {
        //     Event::on(
        //         View::class,
        //         View::EVENT_BEFORE_RENDER_TEMPLATE,
        //         function (TemplateEvent $event) {
        //             try {
        //                 Craft::$app->getView()->registerAssetBundle(SiteModuleAsset::class);
        //             } catch (InvalidConfigException $e) {
        //                 Craft::error(
        //                     'Error registering AssetBundle - '.$e->getMessage(),
        //                     __METHOD__
        //                 );
        //             }
        //         }
        //     );
        // }


        Craft::info(
            Craft::t(
                'site-module',
                '{name} loaded',
                ['name' => 'Site Module']
            ),
            __METHOD__
        );
    }
}
