<?php

use craft\helpers\App;

return [
    'components' => [
        'session' => Craft::createObject([
            'class' => 'yii\redis\Session',
            'redis' => 'redis',
            'keyPrefix' => Craft::$app->id . '-session',
        ])
    ],
];
