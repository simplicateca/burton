<?php

return [
    // Global settings
    '*' => [

        "blockBase" => [
            "container"  => "none",
            "blockClass" => "w-full relative z-20",
            "themeTag"   => "div",

        ],

        "blockpath" => [
            "_site/content/%section%/_%builder%/block.%blocktype%.%entrytype%.%layout%",
            "_site/content/%section%/_%builder%/block.%blocktype%.%entrytype%.%variant%",
            "_site/content/%section%/_%builder%/block.%blocktype%.%entrytype%",
            "_site/content/%section%/_%builder%/block.%blocktype%.%layout%",
            "_site/content/%section%/_%builder%/block.%blocktype%.%variant%",
            "_site/content/%section%/_%builder%/block.%blocktype%",
            "_site/content/%section%/block.%blocktype%.%entrytype%.%layout%",
            "_site/content/%section%/block.%blocktype%.%entrytype%.%variant%",
            "_site/content/%section%/block.%blocktype%.%entrytype%",
            "_site/content/%section%/block.%blocktype%.%layout%",
            "_site/content/%section%/block.%blocktype%.%variant%",
            "_site/content/%section%/block.%blocktype%",
            "_site/content/_%builder%/%blocktype%.%entrytype%.%layout%",
            "_site/content/_%builder%/%blocktype%.%entrytype%.%variant%",
            "_site/content/_%builder%/%blocktype%.%entrytype%",
            "_site/content/_%builder%/%blocktype%.%layout%",
            "_site/content/_%builder%/%blocktype%.%variant%",
            "_site/content/_%builder%/%blocktype%",
            "_site/content/block.%blocktype%.%entrytype%.%layout%",
            "_site/content/block.%blocktype%.%entrytype%.%variant%",
            "_site/content/block.%blocktype%.%entrytype%",
            "_site/content/block.%blocktype%.%layout%",
            "_site/content/block.%blocktype%.%variant%",
            "_site/content/block.%blocktype%",
            "_site/block.%blocktype%",
            "_core/block.%blocktype%",
        ],

        "themeBase" => [
            "default" => "base",
            "tag"     => "div",
            "class"   => "theme relative",
        ],

        "imageBase" => [
            "class"  => "w-full max-w-full h-auto",
            "figure" => "w-full block",
        ],

        "audioBase" => [
            "class" => "block w-full max-w-4xl bg-[#f1f3f4] rounded-none",
        ],

        "videoBase" => [
            "class" => "w-full aspect-video",
        ],

        "iframeBase" => [
            "class" => "w-full aspect-video",
        ],

        "placeholders" => [
            "image" => "https://picsum.photos/seed/#{random(1,9999)}/#{width}/#{height}?grayscale&blur=2",
            "icon"  => "https://placeskull.com/#{width}/#{height}/475569/#{random(1,24)}",
        ],

        "transforms" => [
            "square"     => "square",
            "widescreen" => "widescreen",
        ],
    ],

    // Dev environment settings
    'dev' => [],

    // Staging environment settings
    'staging' => [],

    // Production environment settings
    'production' => [],
];