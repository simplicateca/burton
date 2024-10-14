<?php
/**
 * Theme Core for Craft CMS 5.x
 *
 * @link      https://simplicate.ca
 * @copyright Copyright (c) 2024 simplicate
 */

namespace modules\themecore;

use Craft;
use craft\web\View;
use craft\events\RegisterTemplateRootsEvent;

use yii\base\Module;
use yii\base\Event;
use yii\base\InvalidConfigException;

class ThemeCore extends Module
{
    public static ThemeCore $instance;

    public function __construct($id, $parent = null, array $config = [])
    {
        // Set the module instance
        Craft::setAlias('@modules/themecore', $this->getBasePath());

        // Load Local i18n translations
        self::setupTranslations( $id );

        // Set direcotry paths for control panel and frontend templates
        self::setupTemplates( $this->id, $this->getBasePath() );

        // Load our Control Panel Asset Bundles (CSS/JS)
        self::assetBundle();

        // Set this as the global instance of this module class
        static::setInstance( $this );

        parent::__construct($id, $parent, $config);
    }


    public function init(): void {
        parent::init();
        self::$instance = $this;

        // Enable Twig Extensions
        Craft::$app->view->registerTwigExtension( new \modules\themecore\twigextensions\TextBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\themecore\twigextensions\CardBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\themecore\twigextensions\BuilderBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\themecore\twigextensions\CollectionBaseTwig() );
        Craft::$app->view->registerTwigExtension( new \modules\themecore\twigextensions\MediaBaseTwig() );

        // Report that the module is loaded
        Craft::info( Craft::t( 'theme-core', '{name} loaded', ['name' => 'ThemeCore'] ), __METHOD__ );
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
                'basePath' => '@modules/themecore/translations',
                'forceTranslation' => true,
                'allowOverrides' => true,
            ];
        }
    }


    private static function setupTemplates($id, $basePath = null)
    {
        // Include the module's template directory in the view path for control panel routes
        // $baseDir = $basePath . DIRECTORY_SEPARATOR . 'templates';
        // if( is_dir( $baseDir ) ) {
        //     Event::on( View::class, View::EVENT_REGISTER_CP_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) use ($id, $baseDir) {
        //         $e->roots[$id] = $baseDir;
        //     });
        // }

        // setup the paths that will be available in all twig templates
        Event::on( View::class, View::EVENT_REGISTER_SITE_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) use ($basePath) {
            $e->roots['_core']   = $basePath . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . '_core';
            $e->roots['_hub']    = $basePath . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . '_hub';
            $e->roots['_config'] = CRAFT_BASE_PATH . DIRECTORY_SEPARATOR . 'templates'. DIRECTORY_SEPARATOR .'_config';
            $e->roots['_site']   = CRAFT_BASE_PATH . DIRECTORY_SEPARATOR . 'templates'. DIRECTORY_SEPARATOR .'_site';
        });
    }


    private static function assetBundle()
    {
        if (Craft::$app->getRequest()->getIsCpRequest()) {
            Event::on( View::class, View::EVENT_BEFORE_RENDER_TEMPLATE, function (\craft\events\TemplateEvent $event) {
                try {
                    Craft::$app->getView()->registerAssetBundle( \modules\themecore\assetbundles\themecore\ThemeCoreAsset::class );
                } catch (InvalidConfigException $e) {
                    Craft::error( 'Error registering AssetBundle - ' . $e->getMessage(), __METHOD__ );
                }
            });
        }
    }
}