<?php

return [
    '*' => [
        'enabled' => false,
        'loginPath' => 'knock-knock/who-is-there',
        'template' => '',
        'forcedRedirect' => '',
        'password' => 'letmein',
        'siteSettings' => [],

        'checkInvalidLogins' => false,
        'invalidLoginWindowDuration' => '3600',
        'maxInvalidLogins' => 10,
        'denyIps' => '',
        'useRemoteIp' => false,
        'protectedUrls' => '',
        'unprotectedUrls' => '',

        // buddy.works white list
        'allowIps' => [
            '91.200.38.2',
            '18.219.118.165',
            '18.219.233.31',
            '185.206.228.0/24',
            '93.179.255.178',
        ],
    ],

    'staging' => [
        'enabled' => true,
    ],
];
