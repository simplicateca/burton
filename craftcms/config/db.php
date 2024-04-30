<?php

use craft\helpers\App;

return [
    'driver'      => App::env('CRAFT_DB_DRIVER'),
    'server'      => App::env('CRAFT_DB_SERVER'),
    'port'        => App::env('CRAFT_DB_PORT'),
    'schema'      => App::env('CRAFT_DB_SCHEMA'),
    'tablePrefix' => App::env('CRAFT_DB_TABLE_PREFIX'),

    // TODO: Fix this by renaming env variables when loading in `compose.yaml`
    // don't change these variable names, their necessary the mysql docker image.
    // we use `config/db.php` to make sure CraftCMS recognizes them
    'database' => App::env('MYSQL_DATABASE'),
    'user'     => App::env('MYSQL_USER'),
    'password' => App::env('MYSQL_PASSWORD'),
];
