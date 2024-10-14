<?php

use Craft;
use craft\helpers\App;

return [
    'components' => [
        'session' => static function() {
            $config = App::sessionConfig();
            $config['class'] = \yii\redis\Session::class;
            $config['keyPrefix'] = Craft::$app->id . '-session';
            $config['redis'] = [
                'hostname' => App::env('REDIS_HOSTNAME'),
                'port' => App::env('REDIS_PORT'),
                'password' => App::env('REDIS_PASSWORD') ?: null,
            ];

            return Craft::createObject($config);

        }
    ]
];
