<?php

namespace modules\gearbox\helpers;

use OpenAI;

class OpenAiHelper
{

    private const MODEL = 'gpt-4';

    private const PROMPTS = [
        'metaDescription' =>
"Please read and complete the following steps one-by-one.

- Review the PAGE CONTENT below.
- Create an SEO Meta Description based on the PAGE CONTENT.
- Ensure that the Meta Description adheres SEO and UX best practices.
- Ensure that the length of the Meta Description is no more than 40 words (including spaces).
- Output only the completed description as a single paragraph, without a character count and do not exceed 160 characters.

PAGE CONTENT:
",

    ];

    // Static Methods
    // =========================================================================
    public static function client() {

        $apikey = getenv('OPENAI_SECRET');
        if( $apikey ) {
            return OpenAI::client( $apikey );
        }
        return false;

    }

    public static function metaDescription( $text = '' )
    {
        if( $client = self::client() )
        {
            $response = $client->chat()->create([
                'model'    => self::MODEL,
                'messages' => [
                    ['role' => 'system', 'content' => 'You are a helpful and detail oriented SEO copywriter.'],
                    ['role' => 'user',   'content' => self::PROMPTS['metaDescription'] . trim($text) ],
                ],
            ]);

            $meta = trim( $response->choices[0]->message->content ?? null );
            $meta = trim( $meta, '"' );

            return $meta;
        }

        return null;
    }

}