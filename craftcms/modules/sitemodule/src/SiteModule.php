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

use craft\events\RegisterUserPermissionsEvent;
use craft\services\UserPermissions;

use craft\services\Dashboard;
use craft\events\RegisterComponentTypesEvent;
use modules\sitemodule\widgets\SitehubWidget;

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
            $e->roots['_core'] = CRAFT_BASE_PATH . '/templates/_core';
            $e->roots['_site'] = CRAFT_BASE_PATH . '/templates/_site';
            $e->roots['']      = CRAFT_BASE_PATH . '/templates';
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

        $this->_enableSitehubFunctionality();

        // $this->_registerFrontendRoutes();
        // $this->_registerTwigExtensions();
        // $this->_modifyHtmlPurifier();
        // $this->_registerVariables();
        // $this->_registerConsoleCommands();
        // $this->_loadAssetBundle();

        Craft::info(
            Craft::t(
                'site-module',
                '{name} loaded',
                ['name' => 'Site Module']
            ),
            __METHOD__
        );
    }


    private function _enableSitehubFunctionality()
    {
        // add sitehub user permissions
        Event::on(
            UserPermissions::class,
            UserPermissions::EVENT_REGISTER_PERMISSIONS,
            function(RegisterUserPermissionsEvent $event) {
                $event->permissions[] = [
                    'heading' => 'Sitehub',
                    'permissions' => [
                        'allowSitehub' => [
                            'label' => 'Access to Sitehub',
                        ],
                    ],
                ];
            }
        );

        // Dashboard widget
        Event::on(
            Dashboard::class,
            Dashboard::EVENT_REGISTER_WIDGET_TYPES,
            function(RegisterComponentTypesEvent $event) {
                $event->types[] = SitehubWidget::class;
        });

        // frontend routers ( /sitehub/*/ )
        Event::on(
            UrlManager::class,
            UrlManager::EVENT_REGISTER_SITE_URL_RULES,
            function (RegisterUrlRulesEvent $event) {
                $event->rules['sitehub/blocks/header']              = ['template' => '_site/sitehub/blocks/header'];
                $event->rules['sitehub/blocks/header/<type:\w+>']   = ['template' => '_site/sitehub/blocks/header'];
                $event->rules['sitehub/blocks/sidebar']             = ['template' => '_site/sitehub/blocks/sidebar'];
                $event->rules['sitehub/blocks/sidebar/<type:\w+>']  = ['template' => '_site/sitehub/blocks/sidebar'];

                $event->rules['sitehub/blocks/<type:\w+>']  = ['template' => '_site/sitehub/blocks/index'];
                $event->rules['sitehub/blocks']             = ['template' => '_site/sitehub/blocks/index'];

                $event->rules['sitehub/cards/<type:\w+>']   = ['template' => '_site/sitehub/cards/index'];
                $event->rules['sitehub/cards']              = ['template' => '_site/sitehub/cards/index'];

                $event->rules['sitehub/layout/containers']  = ['template' => '_site/sitehub/layout/containers'];
                $event->rules['sitehub/layout/grids']       = ['template' => '_site/sitehub/layout/grids'];
                $event->rules['sitehub/layout/micro']       = ['template' => '_site/sitehub/layout/micro'];
                $event->rules['sitehub/layout/spacing']     = ['template' => '_site/sitehub/layout/spacing'];
                $event->rules['sitehub/layout/themes']      = ['template' => '_site/sitehub/layout/themes'];
                $event->rules['sitehub/layout/typography']  = ['template' => '_site/sitehub/layout/typography'];
                $event->rules['sitehub/layout']             = ['template' => '_site/sitehub/layout/index'];

                $event->rules['sitehub/playbooks']  = ['template' => '_site/sitehub/playbooks'];
                $event->rules['sitehub/samples']    = ['template' => '_site/sitehub/samples'];

                $event->rules['sitehub']  = ['template' => '_site/sitehub/index'];
            }
        );
    }


    private function _registerFrontendRoutes()
    {
        Event::on(UrlManager::class, UrlManager::EVENT_REGISTER_SITE_URL_RULES,
            function(RegisterUrlRulesEvent $event) {
                $event->rules = array_merge($event->rules, [
                    // 'site-module/whatever' => 'site-module/default/index',
                    // '<entrySlug:{slug}>:<filterSlug:{slug}>' => 'site-module/default/filter',
                    // '<partOne:{slug}>/<entrySlug:{slug}>:<filterSlug:{slug}>' => 'site-module/default/filter',
                    // '<partOne:{slug}>/<partTwo:{slug}>/<entrySlug:{slug}>:<filterSlug:{slug}>' => 'site-module/default/filter',
                ]);
            }
        );
    }


    private function _registerTwigExtensions()
    {
        Craft::$app->view->registerTwigExtension(
            new SiteModuleTwigExtension()
        );
    }


    private function _modifyHtmlPurifier()
    {
        // Allow new attributes (needed by Link Attribute Redactor plugin)
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


    private function _loadAssetBundle()
    {
        // Load our AssetBundle
        if (Craft::$app->getRequest()->getIsCpRequest()) {
            Event::on(
                View::class,
                View::EVENT_BEFORE_RENDER_TEMPLATE,
                function (TemplateEvent $event) {
                    try {
                        Craft::$app->getView()->registerAssetBundle(SiteModuleAsset::class);
                    } catch (InvalidConfigException $e) {
                        Craft::error(
                            'Error registering AssetBundle - '.$e->getMessage(),
                            __METHOD__
                        );
                    }
                }
            );
        }
    }


    private function _registerConsoleCommands()
    {
        if (Craft::$app instanceof ConsoleApplication) {
            $this->controllerNamespace = 'modules\sitemodule\console\controllers';
        }
    }


    private function _registerVariables()
    {
        Event::on(
            CraftVariable::class,
            CraftVariable::EVENT_INIT,
            function (Event $event) {
                /** @var CraftVariable $variable */
                $variable = $event->sender;
                $variable->set('site', SiteVariable::class);
            }
        );
    }

}
