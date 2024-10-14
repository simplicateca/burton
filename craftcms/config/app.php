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

            'redis' => [
                'class' => \yii\redis\Connection::class,
                'hostname' => App::env('REDIS_HOSTNAME') ?: 'localhost',
                'port' => App::env('REDIS_PORT') ?: 6379,
                'password' => App::env('REDIS_PASSWORD') ?: null,
            ],

            'cache' => Craft::createObject([
                'class' => 'yii\redis\Cache',
                'redis' => 'redis',
                'keyPrefix' => Craft::$app->id . '-cache',
                'defaultDuration' => Craft::$app->config->general->cacheDuration,
            ]),

            'queue' => Craft::createObject([
                'class' => 'yii\queue\redis\Queue',
                'redis' => 'redis',
                'keyPrefix' => Craft::$app->id . '-queue',
                'channel' => 'queue',
                'ttr' => 10 * 60,
            ])
        ]
    ],

    'dev' => [
        'components' => [
            'deprecator' => [
                'throwExceptions' => true,
            ],
        ]
    ]
];