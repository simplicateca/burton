<?php
/**
 * Gearbox
 *
 * Common tools, templates, and jigs for Craft CMS 4
 *
 * @author    Steve Comrie
 * @package   Gearbox
 * @since     v0.1
 * @link      https://simplicate.ca
 */

namespace modules\gearbox;

use Craft;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\TemplateEvent;

use craft\web\View;

use craft\elements\Entry;
use craft\events\RegisterElementSourcesEvent;
use craft\events\RegisterUrlRulesEvent;
use craft\web\UrlManager;

use yii\base\Module;
use yii\base\Event;
use yii\base\InvalidConfigException;

use craft\base\Element;
use craft\events\ModelEvent;
use craft\helpers\ElementHelper;

use nystudio107\seomatic\helpers\Text as SeoMaticTextHelper;
use modules\gearbox\helpers\OpenAiHelper as OpenAiHelper;

use modules\gearbox\assetbundles\gearbox\GearboxAsset;
use modules\gearbox\twigextensions\GearboxTwigExtension;
use modules\gearbox\twigextensions\NormalizeBlockTwigExtension;


class Gearbox extends Module
{
    public static Gearbox $instance;

    public function __construct($id, $parent = null, array $config = [])
    {
        Craft::setAlias('@modules/gearbox', $this->getBasePath());

        // Base template directory
        Event::on(
            View::class,
            View::EVENT_REGISTER_CP_TEMPLATE_ROOTS,
            function (RegisterTemplateRootsEvent $e
        ) {
            if (is_dir($baseDir = $this->getBasePath().DIRECTORY_SEPARATOR.'templates')) {
                $e->roots[$this->id] = $baseDir;
            }
        });

        // Set this as the global instance of this module class
        static::setInstance($this);
        parent::__construct($id, $parent, $config);
    }


    public function init()
    {
        parent::init();
        self::$instance = $this;

        $this->_registerTwigExtensions();
        $this->_loadControlPanelAssetBundle();
        $this->_enableSidebarEntryTypeNav();
        // $this->_enableAutoCompleteChatGPT();
    }


    private function _registerTwigExtensions()
    {
        Craft::$app->view->registerTwigExtension( new GearboxTwigExtension() );
        Craft::$app->view->registerTwigExtension( new NormalizeBlockTwigExtension() );
    }


    private function _loadControlPanelAssetBundle()
    {
        if (Craft::$app->getRequest()->getIsCpRequest()) {
            Event::on(
                View::class,
                View::EVENT_BEFORE_RENDER_TEMPLATE,
                function (TemplateEvent $event) {
                    try {
                        Craft::$app->getView()->registerAssetBundle(GearboxAsset::class);
                    } catch (InvalidConfigException $e) {
                        Craft::error(
                            'Error registering AssetBundle - '.$e->getMessage(),
                            __METHOD__
                        );
                    }
                }
            );
        }
    }


    private function _enableAutoCompleteChatGPT()
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
                    $headerBlocks = in_array( 'headerBuilder',  $fieldHandles ) ? $entry->getFieldValue('headerBuilder')->all()  : [];
                    $bodyBlocks   = in_array( 'contentBuilder', $fieldHandles ) ? $entry->getFieldValue('contentBuilder')->all() : [];

                    $text = SeoMaticTextHelper::extractTextFromMatrix( array_filter( [...$headerBlocks, ...$bodyBlocks] ) );

                    if( $text && $meta = OpenAiHelper::metaDescription( empty($headerBlocks) ? "$title $text" : $text ) )
                    {
                        $entry->setFieldValue('dek', $meta );
                    }
                }
            }
        );
    }


    // Sidebar Entry Types / Section Navigation
    // roughly based on: https://github.com/ethercreative/sidebar-entrytypes
    private function _enableSidebarEntryTypeNav()
    {
        Event::on(Entry::class, Entry::EVENT_REGISTER_SOURCES, function(RegisterElementSourcesEvent $event) {

            if( $event->context == 'modal' ) { return $event->sources; }

            $newSources = [];
            foreach ( $event->sources as &$source ) {

                $sectionType  = $source['data']['type'] ?? null;
                $sectionId    = $source['criteria']['sectionId'] ?? null;

                if( !is_int( $sectionId ) ) {
                    $newSources[] = $source;
                    continue;
                }

                $entryTypes = Craft::$app->sections->getEntryTypesBySectionId( $sectionId );

                if( count($entryTypes) < 2 || $sectionType != 'channel' ) {
                    $newSources[] = $source;
                    continue;
                }

                $children = [];
                foreach( $entryTypes AS $type ) {

                    $typeSource = [
                        'type'  => 'custom',
                        'label' => $type->name,
                        'key'   => $source['key'] . ':' . $type->handle,
                        'data'  => [
                            'handle'     => $type->section->handle,
                            'entry-type' => $type->handle,
                        ],
                        'criteria' => [
                            'sectionId' => $source['criteria']['sectionId'] ?? null,
                            'editable'  => $source['criteria']['editable'] ?? null,
                            'typeId'    => $type->id,
                        ],
                        'condition' => [
                            'class' => 'craft\elements\conditions\entries\EntryCondition',
                            'conditionRules' => [[
                                'class'    => 'craft\elements\conditions\entries\SectionConditionRule',
                                'operator' => 'in',
                                'uid'      => '',
                                'values'   => [$type->section->uid] ?? null
                            ],[
                                'class'    => 'craft\elements\conditions\entries\TypeConditionRule',
                                'operator' => 'in',
                                'uid'      => '',
                                'values'   => [$type->uid] ?? null
                            ]],
                        ],
                        'elementType'     => 'craft\elements\Entry',
                        'fieldContext'    => 'global',
                        'defaultSort'     => $source['defaultSort'] ?? null,
                        'tableAttributes' => $source['tableAttributes'] ?? null,
                    ];

                    $children[] = $typeSource;
                }

                if( !empty( $children ) ) {
                    $source['nested'] = $children;
                }

                $newSources[] = $source;
            }

            $event->sources = $newSources;
        });
    }
}
