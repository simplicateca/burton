<?php

use craft\helpers\App;

return [
    '*' => [
        'useDevServer' => false,
        'checkDevServer' => false,
        'cacheKeySuffix' => '',
        'includeReactRefreshShim' => false,
        'includeModulePreloadShim' => true,
        'serverPublic' => App::env('CRAFT_WEB_URL')  . '/dist/',
        'manifestPath' => App::env('CRAFT_WEB_ROOT') . '/dist/manifest.json',
        'criticalPath' => App::env('CRAFT_WEB_ROOT') . '/dist/criticalcss',
        'criticalSuffix' =>'_critical.min.css',
    ],
    'dev' => [
        'useDevServer' => true,
        'checkDevServer' => true,
        'errorEntry' => 'js/app.js',
        'devServerPublic' => App::env('VITE_DEV_SERVER_PUBLIC'),
        'devServerInternal' => App::env('VITE_DEV_SERVER_INTERNAL'),
    ]
];
