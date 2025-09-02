<?php

use craft\helpers\App;

return [
    '*' => [
        'cachingEnabled' => false,
    ],

    'production' => [
        'cachingEnabled' => !(getenv('CRAFT_DEV_MODE') ?? false),
    ],
];
