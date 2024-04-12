<?php
/**
 * Site Module for Craft CMS 4.x
 *
 * @link      https://simplicate.ca
 * @copyright Copyright (c) 2024 simplicate
 */

namespace modules\sitemodule;

use Craft;
use craft\web\View;
use craft\events\RegisterTemplateRootsEvent;

use yii\base\Module;
use yii\base\Event;
use yii\base\InvalidConfigException;

use modules\sitemodule\helpers\SitehubHelper;
use modules\sitemodule\helpers\OpenAiHelper;
use modules\sitemodule\helpers\HtmlTextHelper;
use modules\sitemodule\helpers\EntrySidebarHelper;


class SiteModule extends Module
{
    public static SiteModule $instance;

    public function __construct($id, $parent = null, array $config = [])
    {
        // Set the module instance
        Craft::setAlias('@modules/sitemodule', $this->getBasePath());
        $this->controllerNamespace = 'modules\sitemodule\controllers';
        if( Craft::$app instanceof \craft\console\Application ) {
            $this->controllerNamespace = 'modules\sitemodule\console\controllers';
        }

        // Load Local i18n translations
        self::setupTranslations( $id );

        // Set direcotry paths for control panel and frontend templates
        self::setupTemplates( $this->id, $this->getBasePath() );

        // Load our Control Panel Asset Bundles (CSS/JS)
        self::assetBundle();

        // Register Control Panel Asset Bunch
        self::frontendRoutes();

        // Set this as the global instance of this module class
        static::setInstance( $this );

        parent::__construct($id, $parent, $config);
    }


    public function init(): void
    {
        parent::init();
        self::$instance = $this;

        // Enable Sitehub Functionality
        SitehubHelper::enable();

        // Let OpenAI autofill missing summary fields
        OpenAiHelper::enable();

        // Redactor, Html Purifier, and other helpers related to managing HTML / Rich Text field content.
        HtmlTextHelper::enable();

        // Basically a copy of the old Sidebar Entry Type Helper
        EntrySidebarHelper::enable();

        // Enable Twig Extensions
        Craft::$app->view->registerTwigExtension( new \modules\sitemodule\twigextensions\TextBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\sitemodule\twigextensions\CardBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\sitemodule\twigextensions\BlockBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\sitemodule\twigextensions\CollectionBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\sitemodule\twigextensions\MediaBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\sitemodule\twigextensions\ToolboxTwig() );

        // Report that the module is loaded
        Craft::info( Craft::t( 'site-module', '{name} loaded', ['name' => 'Site Module'] ), __METHOD__ );
    }


    // frontend routes
    private static function frontendRoutes()
    {
        Event::on(\craft\web\UrlManager::class, \craft\web\UrlManager::EVENT_REGISTER_SITE_URL_RULES,
            function(\craft\events\RegisterUrlRulesEvent $event) {
                // $event->rules = array_merge($event->rules, [
                //     'site-module/whatever' => 'site-module/default/index',
                // ]);
            }
        );
    }


    private static function setupTranslations($id)
    {
        // Translation category
        $i18n = Craft::$app->getI18n();

        /** @noinspection UnSafeIsSetOverArrayInspection */
        if (!isset($i18n->translations[$id]) && !isset($i18n->translations[$id.'*'])) {
            $i18n->translations[$id] = [
                'class' => \craft\i18n\PhpMessageSource::class,
                'sourceLanguage' => 'en-US',
                'basePath' => '@modules/sitemodule/translations',
                'forceTranslation' => true,
                'allowOverrides' => true,
            ];
        }
    }


    private static function setupTemplates($id, $basePath = null)
    {
        // Include the module's template directory in the view path for control panel routes
        $baseDir = $basePath . DIRECTORY_SEPARATOR . 'templates';
        if( is_dir( $baseDir ) ) {
            Event::on( View::class, View::EVENT_REGISTER_CP_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) use ($id, $baseDir) {
                $e->roots[$id] = $baseDir;
            });
        }


        // Include `craftcms/templates` in the template path for templates in `craftcms/modules/sitemodule/templates`
        Event::on( View::class, View::EVENT_REGISTER_SITE_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) {
            $e->roots['_core']  = CRAFT_BASE_PATH . '/templates/_core';
            $e->roots['_email'] = CRAFT_BASE_PATH . '/templates/_email';
            $e->roots['_site']  = CRAFT_BASE_PATH . '/templates/_site';
            $e->roots['']       = CRAFT_BASE_PATH . '/templates';
        });


        // Add SiteVariable to Template
        // Event::on( \craft\web\twig\variables\CraftVariable::class, \craft\web\twig\variables\CraftVariable::EVENT_INIT, function (Event $event) {
        //     $variable = $event->sender;
        //     $variable->set('site', \modules\sitemodule\variables\SiteVariable::class);
        // });
    }


    private static function assetBundle()
    {
        if (Craft::$app->getRequest()->getIsCpRequest()) {
            Event::on( View::class, View::EVENT_BEFORE_RENDER_TEMPLATE, function (\craft\events\TemplateEvent $event) {
                try {
                    Craft::$app->getView()->registerAssetBundle( \modules\sitemodule\assetbundles\sitemodule\SiteModuleAsset::class );
                } catch (InvalidConfigException $e) {
                    Craft::error( 'Error registering AssetBundle - ' . $e->getMessage(), __METHOD__ );
                }
            });
        }
    }
}