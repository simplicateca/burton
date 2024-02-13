<?php

$commonFields = ['variant', 'theme', 'source', 'text', 'layout', 'interspace'];
$commonFieldsHeaders = [...$commonFields, 'headline'];

if( !function_exists('burtonBuilderConfig') ) { function burtonBuilderConfig( $commonFields ) {

    $contentTabLabel = 'Content';

    return [
        'defaultTabName' => '⚛ Advanced',
        'types' => [
            'text' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'text2', 'bits', 'summary', 'format'],
                ]],
            ],

            'image' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'collections', 'format', 'interface', 'images'],
                ]],
            ],

            'media' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'collections', 'format', 'interface', 'assets', 'embeds', 'code'],
                ]],
            ],

            'collection' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'collections', 'format', 'interface', 'entries', 'items'],
                ]],
            ],

            'focus' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'collections', 'format', 'interface', 'entries', 'form', 'component'],
                ]],
            ],
        ],
    ];
} }

return [
    'fields' => [
        'headerBuilder'  => burtonBuilderConfig( $commonFieldsHeaders ),
        'sidebarBuilder' => burtonBuilderConfig( $commonFields ),
        'bodyBuilder'    => burtonBuilderConfig( $commonFields ),
    ]
];