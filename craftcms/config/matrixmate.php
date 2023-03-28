<?php

return [
    'fields' => [

        'headerBuilder' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'headline', 'text', 'bg', 'spacing'],
                    ]],
                ],

                'textImage' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'headline', 'text', 'images', 'bg', 'spacing'],
                    ]],
                ],

                'media' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'headline', 'text', 'media', 'bg', 'spacing'],
                    ]],
                ],
            ]
        ],

        'sidebarBuilder' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'images', 'bg', 'spacing'],
                        
                    ]],
                ],

                'textImage' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'images', 'bg', 'spacing'],
                    ]],
                ]
            ]
        ],

        'contentBuilder' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'images', 'bg', 'spacing'],
                        
                    ]],
                ],

                'textImage' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'images', 'bg', 'spacing'],
                    ]],
                ],

                'textText' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'text2', 'images', 'bg', 'spacing'],
                    ]],
                ],

                'media' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'media', 'externalMedia', 'bg', 'spacing'],
                    ]],
                ],

                'entries' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'method', 'items', 'bg', 'spacing'],
                    ]],
                ],

                'contentRepeater' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'items', 'images', 'bg', 'spacing'],
                    ]],
                ]
            ],
        ],
    ]
];