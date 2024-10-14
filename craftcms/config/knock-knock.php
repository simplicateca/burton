<?php

use craft\helpers\App;

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

        'allowIps' => [
            // Buddy IPs
            // https://buddy.works/docs/troubleshooting/ip-whitelisting/us-region
            // Updated: 2024-10-14
            '91.200.38.2',
            '18.219.118.165',
            '18.219.233.31',
            '185.206.228.0/24',
            '93.179.255.178',
            '185.171.161.0/24',
            '13.59.219.251',
            '18.191.75.59',
            '18.216.111.144',
            '3.139.231.80',
            '3.14.55.153',
            '3.141.228.183',
            '3.142.137.33',
            '3.143.63.167',
            '3.19.187.33',
            '3.21.131.165',
            '69.194.3.31',
            '69.194.3.94',

            // Ploi IPs
            // https://ploi.io/documentation/introduction/ploi-ip-for-whitelisting
            // Updated: 2024-10-14
            '5.22.210.148',
            '94.237.42.145',
            '94.237.47.71',
            '94.237.102.252',
        ],
    ],

    'staging' => [
        'enabled' => true,
    ]
];
