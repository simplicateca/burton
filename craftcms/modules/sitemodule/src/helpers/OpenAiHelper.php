<?php

namespace modules\sitemodule\helpers;

use OpenAI;
use nystudio107\seomatic\helpers\Text as SeoMaticTextHelper;

use craft\elements\Entry;

use yii\base\Event;

use craft\base\Element;
use craft\events\ModelEvent;
use craft\helpers\ElementHelper;

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

    // Enable OpenAI Functionality
    public static function enable()
    {
        // use OpenAI to automatically summarize entry types that have a dek field using the text contents of matrix builder blocks
        Event::on(
            Entry::class,
            Element::EVENT_BEFORE_SAVE,
            function(ModelEvent $e) {

                /* @var Entry $entry */
                $entry = $e->sender;

                if( ElementHelper::isDraftOrRevision($entry) ) {
                    // don’t do anything with drafts or revisions
                    return;
                }

                // get the custom fields associated with this element
                $elementFields = $entry->getFieldLayout()->getCustomFields();
                $fieldHandles  = array_column($elementFields, 'handle');

                if( in_array( 'dek', $fieldHandles ) && empty( $entry->getFieldValue('dek') ) )
                {
                    $title        = $entry->title;
                    $headerBlocks = in_array( 'headerBuilder', $fieldHandles ) ? $entry->getFieldValue('headerBuilder')->all() : [];
                    $bodyBlocks   = in_array( 'bodyBuilder',   $fieldHandles ) ? $entry->getFieldValue('bodyBuilder')->all()   : [];

                    $text = SeoMaticTextHelper::extractTextFromMatrix( array_filter( [...$headerBlocks, ...$bodyBlocks] ) );

                    if( $text && $meta = self::metaDescription( empty($headerBlocks) ? "$title $text" : $text ) )
                    {
                        $entry->setFieldValue('dek', $meta );
                    }
                }
            }
        );
    }


    // Get the OpenAI Client
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