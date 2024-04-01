<?php

return [
    // Global settings
    '*' => [

        "blockBase" => [
            "container"  => "none",
            "blockClass" => "w-full relative z-20",
            "themeTag"   => "div",

        ],

        "blockTemplates" => [
            "_site/content/%section%/_%builder%/block.%blockType%.%entryType%.%layout%",
            "_site/content/%section%/_%builder%/block.%blockType%.%entryType%.%variant%",
            "_site/content/%section%/_%builder%/block.%blockType%.%entryType%",
            "_site/content/%section%/_%builder%/block.%blockType%.%layout%",
            "_site/content/%section%/_%builder%/block.%blockType%.%variant%",
            "_site/content/%section%/_%builder%/block.%blockType%",
            "_site/content/%section%/block.%blockType%.%entryType%.%layout%",
            "_site/content/%section%/block.%blockType%.%entryType%.%variant%",
            "_site/content/%section%/block.%blockType%.%entryType%",
            "_site/content/%section%/block.%blockType%.%layout%",
            "_site/content/%section%/block.%blockType%.%variant%",
            "_site/content/%section%/block.%blockType%",
            "_site/content/_%builder%/%blockType%.%entryType%.%layout%",
            "_site/content/_%builder%/%blockType%.%entryType%.%variant%",
            "_site/content/_%builder%/%blockType%.%entryType%",
            "_site/content/_%builder%/%blockType%.%layout%",
            "_site/content/_%builder%/%blockType%.%variant%",
            "_site/content/_%builder%/%blockType%",
            "_site/content/block.%blockType%.%entryType%.%layout%",
            "_site/content/block.%blockType%.%entryType%.%variant%",
            "_site/content/block.%blockType%.%entryType%",
            "_site/content/block.%blockType%.%layout%",
            "_site/content/block.%blockType%.%variant%",
            "_site/content/block.%blockType%",
            "_site/block.%blockType%",
            "_core/block.%blockType%",
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