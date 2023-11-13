<?php

return [
    'fields' => [

        'headerBuilder' => [
            'defaultTabName' => '⚛ Advanced',
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'headline', 'text', 'theme', 'interspace'],
                    ]],
                ],

                'image' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'headline', 'text', 'images', 'theme', 'interspace'],
                    ]],
                ],

                'media' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'headline', 'text', 'source', 'assets', 'embeds', 'theme', 'interspace'],
                    ]],
                ],
            ]
        ],

        'sidebarBuilder' => [
            'defaultTabName' => '⚛ Advanced',
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'images', 'theme', 'interspace'],

                    ]],
                ],

                'image' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'images', 'theme', 'interspace'],
                    ]],
                ],

                'media' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'source', 'assets', 'embeds', 'theme', 'interspace'],
                    ]],
                ],

                'collection' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'source', 'entries', 'assets', 'feed', 'text', 'items', 'limit', 'pagination', 'theme', 'interspace'],
                    ]],
                ]
            ]
        ],

        'contentBuilder' => [
            'defaultTabName' => '⚛ Advanced',
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'theme', 'interspace'],
                    ]],
                ],

                'textDouble' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'text2', 'theme', 'interspace'],
                    ]],
                ],

                'image' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'images', 'theme', 'interspace'],
                    ]],
                ],

                'media' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'source', 'assets', 'embeds', 'theme', 'interspace'],
                    ]],
                ],

                'collection' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'source', 'entries', 'assets', 'feeds', 'items', 'limit', 'pagination', 'theme', 'interspace'],
                    ]],
                ],

                'special' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'feeds', 'form', 'menu', 'code', 'theme', 'interspace'],
                    ]],
                ],
            ],
        ],
    ]
];