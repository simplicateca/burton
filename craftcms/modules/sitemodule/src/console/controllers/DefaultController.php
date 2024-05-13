<?php
/**
 * Site Module - Console Controller
 *
 * Create any site specific console commands here
 */

namespace modules\sitemodule\console\controllers;

use modules\sitemodule\SiteModule;

use Craft;
use yii\console\Controller;
use yii\helpers\Console;

/**
 * Default Command
 *
 * The first line of this class doc-block is displayed as the description
 * of the Console Command in ./craft help
 *
 * Craft can be invoked via commandline console by using the `./craft` command
 * from the project root.
 *
 * Console Commands are just controllers that are invoked to handle console
 * actions. The segment routing is module-name/controller-name/action-name
 *
 * The actionIndex() method is what is executed if no sub-commands are supplied, e.g.:
 *
 * ./craft site-module/default
 *
 * Actions must be in 'kebab-case' so actionDoSomething() maps to 'do-something',
 * and would be invoked via:
 *
 * ./craft site-module/default/do-something
 */

 use craft\elements\Entry;

 class DefaultController extends Controller
{
    /**
     * Handle site-module/default console commands
     *
     * The first line of this method doc-block is displayed as the description
     * of the Console Command in ./craft help
     *
     * @return mixed
     */
    public function actionIndex(): mixed
    {
        $result = 'something';

        echo "Welcome to the console DefaultController actionIndex() method\n";

        return $result;
    }


    // What is this here?!
    // ----------------------------------------------------------------------------------
    // Playing around with updating the `slug` field of Formie entries. It appears to be
    // unused and is convienently one of the few default fields that can be used to make
    // a "dynamic" Custom Source in the Control Panel.
    //
    // A Custom Source in Formie allows you to create filterable options when creating a
    // custom Formie Entry select field (i.e. within Component Blocks).
    // ----------------------------------------------------------------------------------
    // public function actionFormSlug(): mixed
    // {
    //     $element = Craft::$app->getElements()->getElementById(99);
    //     $element->slug = 'contact-form-embeddable';
    //     Craft::$app->getElements()->saveElement($element);
    //     return "";
    // }
}