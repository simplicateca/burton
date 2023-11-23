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
use craft\events\RegisterUserPermissionsEvent;
use craft\events\TemplateEvent;
use craft\services\UserPermissions;
use craft\redactor\Field AS RedactorField;
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

        $this->registerTwigExtensions();
        $this->loadControlPanelAssetBundle();
        $this->enableSitebookFunctionality();
        $this->modifyHtmlPurifierConfig();
        $this->enableAutoCompleteChatGPT();
        $this->enableSidebarEntryTypeNav();
    }


    protected function registerTwigExtensions()
    {
        Craft::$app->view->registerTwigExtension( new GearboxTwigExtension() );
        Craft::$app->view->registerTwigExtension( new NormalizeBlockTwigExtension() );
    }


    protected function loadControlPanelAssetBundle()
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


    protected function modifyHtmlPurifierConfig()
    {
        // Modify HTML Purifier config to allow new attribute (needed by Link Attribute Redactor plugin)
        // Event::on(
        //     RedactorField::class,
        //     RedactorField::EVENT_MODIFY_PURIFIER_CONFIG,
        //     function (Event $event) {
        //         if( $event->config ) {
        //             if( $def = $event->config->getDefinition('HTML', true) ) {
        //                 $def->addAttribute('a', 'aria-label', 'Text');
        //                 $def->addAttribute('a', 'data-ident', 'Text');
        //                 $def->addAttribute('a', 'data-modal', 'Bool');
        //             }
        //         }
        //     }
        // );
    }


    protected function enableSitebookFunctionality()
    {
        // add sitebook user permissions
        Event::on(
            UserPermissions::class,
            UserPermissions::EVENT_REGISTER_PERMISSIONS,
            function(RegisterUserPermissionsEvent $event) {
                $event->permissions[] = [
                    'heading' => 'Sitebook',
                    'permissions' => [
                        'allowSitebook' => [
                            'label' => 'Access to Sitebook',
                        ],
                    ],
                ];
            }
        );

        // Register our site routes
        Event::on(
            UrlManager::class,
            UrlManager::EVENT_REGISTER_SITE_URL_RULES,
            function (RegisterUrlRulesEvent $event) {
                $event->rules['sitebook/blocks/<type:\w+>'] = ['template' => 'sitebook/blocks/editor.twig'];
            }
        );

    }


    protected function enableAutoCompleteChatGPT()
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
    public function enableSidebarEntryTypeNav()
    {
        Event::on(Entry::class, Entry::EVENT_REGISTER_SOURCES, function(RegisterElementSourcesEvent $event) {

            $singlesSource = null;

            if( $event->context == 'modal' ) { return $event->sources; }

            $newSources = [];
            foreach ( $event->sources as &$source ) {

                $sectionType  = $source['data']['type'] ?? null;
                $sectionId    = $source['criteria']['sectionId'] ?? null;
                $sourceKey    = $source['key'] ?? null;

                if( ( $sourceKey ?? null ) == 'singles' ) {
                    $singlesSource = $source;
                    continue;
                }

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

                    $typeSource = $source;
                    $typeSource['key'] = $source['key'] . ':' . $type->handle;
                    $typeSource['label'] = $type->name;
                    $typeSource['criteria']['typeId'] = $type->id;

                    $children[] = $typeSource;
                }

                if( $sourceKey == 'section:89093e20-515d-4e3c-b4c4-c6733d8ab56f' && $singlesSource ) {
                    $children[] = $singlesSource;
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
