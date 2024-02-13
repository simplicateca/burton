<?php

namespace modules\sitemodule\helpers;

use modules\sitemodule\widgets\SitehubWidget;
use craft\events\RegisterUserPermissionsEvent;
use craft\services\UserPermissions;
use craft\services\Dashboard;
use craft\events\RegisterComponentTypesEvent;
use craft\events\RegisterUrlRulesEvent;
use craft\web\UrlManager;

use yii\base\Event;

class SitehubHelper
{
    // Enable Sitehub Functionality
    public static function enable()
    {
        self::_frontendRoutes();
        self::_userPermissions();
        self::_dashboardWidget();
    }


    // Frontend Route -> /sitehub/*
    private static function _frontendRoutes() {
        Event::on(
            UrlManager::class,
            UrlManager::EVENT_REGISTER_SITE_URL_RULES,
            function (RegisterUrlRulesEvent $event) {
                $event->rules['sitehub/blocks/header']              = ['template' => '_sitehub/blocks/header'];
                $event->rules['sitehub/blocks/header/<type:\w+>']   = ['template' => '_sitehub/blocks/header'];
                $event->rules['sitehub/blocks/sidebar']             = ['template' => '_sitehub/blocks/sidebar'];
                $event->rules['sitehub/blocks/sidebar/<type:\w+>']  = ['template' => '_sitehub/blocks/sidebar'];

                $event->rules['sitehub/blocks/<type:\w+>']  = ['template' => '_sitehub/blocks/index'];
                $event->rules['sitehub/blocks']             = ['template' => '_sitehub/blocks/index'];

                $event->rules['sitehub/cards/<type:\w+>']   = ['template' => '_sitehub/cards/index'];
                $event->rules['sitehub/cards']              = ['template' => '_sitehub/cards/index'];

                $event->rules['sitehub/layout/containers']  = ['template' => '_sitehub/layout/containers'];
                $event->rules['sitehub/layout/grids']       = ['template' => '_sitehub/layout/grids'];
                $event->rules['sitehub/layout/micro']       = ['template' => '_sitehub/layout/micro'];
                $event->rules['sitehub/layout/spacing']     = ['template' => '_sitehub/layout/spacing'];
                $event->rules['sitehub/layout/themes']      = ['template' => '_sitehub/layout/themes'];
                $event->rules['sitehub/layout/typography']  = ['template' => '_sitehub/layout/typography'];
                $event->rules['sitehub/layout']             = ['template' => '_sitehub/layout/index'];

                $event->rules['sitehub/playbooks']  = ['template' => '_sitehub/playbooks'];
                $event->rules['sitehub/samples']    = ['template' => '_sitehub/samples'];

                $event->rules['sitehub']  = ['template' => '_sitehub/index'];
            }
        );
    }


    // Admin Dashboard Widget
    private static function _dashboardWidget() {
        Event::on(
            Dashboard::class,
            Dashboard::EVENT_REGISTER_WIDGET_TYPES,
            function(RegisterComponentTypesEvent $event) {
                $event->types[] = SitehubWidget::class;
        });
    }


    // Add Dashboard User Permissions
    private static function _userPermissions() {
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
    }
}