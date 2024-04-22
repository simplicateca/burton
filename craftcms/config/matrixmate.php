<?php

$commonFields = ['variant', 'layout', 'theme', 'source', 'text'];
$commonFieldsHeaders = [...$commonFields, 'headline'];

if( !function_exists('matrixbuilder__fieldconfig') ) { function matrixbuilder__fieldconfig( $commonFields ) {

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
                    'fields' => [...$commonFields, 'collections', 'images'],
                ]],
            ],

            'media' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'collections', 'media', 'external', 'code'],
                ]],
            ],

            'carddeck' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'collections', 'entries', 'items'],
                ]],
            ],

            'component' => [
                'tabs' => [[
                     'label' => $contentTabLabel,
                    'fields' => [...$commonFields, 'collections', 'form', 'element'],
                ]],
            ],
        ],
    ];
} }

return [
    'fields' => [
        'headerBuilder'  => matrixbuilder__fieldconfig( $commonFieldsHeaders ),
        'sidebarBuilder' => matrixbuilder__fieldconfig( $commonFields ),
        'bodyBuilder'    => matrixbuilder__fieldconfig( $commonFields ),
        'pageExtras'     => [
            'hiddenTypes' => ['entranceModal'],
            'types' => [
                'alertMessage'  => [ 'maxLimit' => 1 ],
                'footerCta'     => [ 'maxLimit' => 1 ],
                'entranceModal' => [ 'maxLimit' => 1 ],
                'jsEvent'       => [ 'maxLimit' => 1 ],
                'navigation'    => [ 'maxLimit' => 1 ],
            ],
            'groups' => [[
                'label' => 'Add Extra',
                'types' => ['alertMessage', 'footerCta', 'entranceModal', 'jsEvent', 'navigation'],
            ]],
        ]
    ]
];