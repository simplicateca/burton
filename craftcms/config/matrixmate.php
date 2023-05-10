<?php

return [
    'fields' => [

        'headerBuilder' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'singleText' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'headline', 'text', 'bg', 'spacing'],
                    ]],
                ],

                'imageContent' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'headline', 'text', 'images', 'bg', 'spacing'],
                    ]],
                ],

                'richMedia' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'headline', 'text', 'assetSource', 'localAssets', 'externalUrls', 'bg', 'spacing'],
                    ]],
                ],
            ]
        ],

        'sidebarBuilder' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'singleText' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'text', 'images', 'bg', 'spacing'],

                    ]],
                ],

                'imageFeature' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'images', 'bg', 'spacing'],
                    ]],
                ],

                'richMedia' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'text', 'assetSource', 'localAssets', 'externalUrls', 'bg', 'spacing'],
                    ]],
                ],

                'collection' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'collectionType', 'entries', 'assets', 'searches', 'text', 'items', 'limit', 'pagination', 'images', 'bg', 'spacing'],
                    ]],
                ]
            ]
        ],

        'contentBuilder' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'singleText' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'text', 'bg', 'spacing'],
                    ]],
                ],

                'textColumns' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'text2', 'bg', 'spacing'],
                    ]],
                ],

                'imageFeature' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'text', 'images', 'bg', 'spacing'],
                    ]],
                ],

                'richMedia' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'text', 'assetSource', 'localAssets', 'externalUrls', 'bg', 'spacing'],
                    ]],
                ],

                'collection' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['layout', 'variant', 'collectionType', 'entries', 'assets', 'searches', 'text', 'items', 'limit', 'pagination', 'images', 'bg', 'spacing'],
                    ]],
                ],

                'specialElement' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'searches', 'bg', 'spacing'],
                    ]],
                ],
            ],
        ],
    ]
];