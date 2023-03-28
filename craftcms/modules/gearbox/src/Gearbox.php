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
use craft\events\RegisterComponentTypesEvent;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\RegisterUserPermissionsEvent;
use craft\events\TemplateEvent;
use craft\services\Fields;
use craft\services\UserPermissions;
use craft\redactor\Field AS RedactorField;
use craft\web\View;

use craft\base\Element;
use craft\elements\Entry;
use craft\models\Section;
use craft\events\RegisterElementSourcesEvent;
use craft\events\RegisterElementActionsEvent;

use yii\base\Module;
use yii\base\Event;
use yii\base\InvalidConfigException;

use modules\gearbox\assetbundles\gearbox\GearboxAsset;
use modules\gearbox\twigextensions\GearboxTwigExtension;

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

        // Add our TwigExtension(s)
        Craft::$app->view->registerTwigExtension(
            new GearboxTwigExtension()
        );

        // Load our AssetBundle
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


        // Modify HTML Purifier config to allow new attribute (needed by Link Attribute Redactor plugin)
        Event::on(
            RedactorField::class,
            RedactorField::EVENT_MODIFY_PURIFIER_CONFIG,
            function (Event $event) {
                if( $event->config ) {
                    if( $def = $event->config->getDefinition('HTML', true) ) {
                        $def->addAttribute('a', 'aria-label', 'Text');
                        $def->addAttribute('a', 'data-ident', 'Text');
                        $def->addAttribute('a', 'data-modal', 'Bool');
                    }
                }
            }
        );


        // Register our permissions
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

        
        // Sidebar Entry Types / Section Navigation
        // per: https://github.com/ethercreative/sidebar-entrytypes
        Event::on(Entry::class, Element::EVENT_REGISTER_SOURCES, function(RegisterElementSourcesEvent $event) {
            $children = [];
      
            foreach ($event->sources as $i => $source) {
                if (!isset($source['data'])) {
                    continue;
                }

                $entryTypes = Craft::$app->sections->getEntryTypesBySectionId($source['criteria']['sectionId']);
      
                $sectionType    = $source['data']['type']           ?? '';
                $sectionHandle  = $source['data']['handle']         ?? '';
                $sectionSort    = $source['data']['defaultSort'][0] ?? 'postDate';
                $sectionSortDir = $source['data']['defaultSort'][1] ?? 'desc';

                if( count($entryTypes) < 2 || $sectionType == 'structure' ) {
                    continue;
                }
      
                $children[$i] = [];
                               
                foreach ($entryTypes as $entryType) {
                    $children[$i][] = [
                        'key' => 'section:' . $entryType->uid,
                        'label' => $entryType->name,
                        'data' => [
                            'default-sort' => $sectionSort . ':' . $sectionSortDir,
                            'type' => $sectionType,
                            'handle' => $sectionHandle,
                            'type-id' => $entryType->id,
                            'entry-type' => true
                        ],
                        'criteria' => [
                            'sectionId' => $entryType->sectionId,
                            'type' => $entryType->handle,
                            'editable' => false,
                        ]
                    ];
                }

            }
      
            foreach ($children as $key => $child) {
                $event->sources[$key]['nested'] = $child;
            }
        });
    }
}
