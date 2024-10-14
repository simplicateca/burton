<?php

use craft\helpers\App;

return [
    '*' => [
        'id' => App::env('CRAFT_APP_ID') ?: 'CraftCMS',
        'modules' => [
            'site-module' => [ 'class' => \modules\sitemodule\SiteModule::class ],
            'theme-core'  => [ 'class' => \modules\themecore\ThemeCore::class ]
        ],
        'bootstrap' => ['site-module', 'theme-core', 'queue'],
        'components' => [
            'deprecator' => [
                'throwExceptions' => false,
            ],

            'cache' => function() {
                return Craft::createObject([
                    'class' => yii\redis\Cache::class,
                    'keyPrefix' => Craft::$app->id . '-cache',
                    'defaultDuration' => Craft::$app->config->general->cacheDuration,
                    'redis' => [
                        'hostname' => App::env('REDIS_HOSTNAME') ?: 'localhost',
                        'port' => App::env('REDIS_PORT') ?: 6379,
                        'password' => App::env('REDIS_PASSWORD') ?: null,
                    ],
                ]);
            },

            'queue' => [
                'proxyQueue' => [
                    'class' => yii\queue\redis\Queue::class,
                    'redis' => [
                        'hostname' => App::env('REDIS_HOSTNAME') ?: 'localhost',
                        'port' => App::env('REDIS_PORT') ?: 6379,
                        'password' => App::env('REDIS_PASSWORD') ?: null,
                    ],
                ],
                'channel' => 'queue'
            ]
        ]
    ],

    'dev' => [
        'components' => [
            'deprecator' => [
                'throwExceptions' => true,
            ]
        ]
    ]
];