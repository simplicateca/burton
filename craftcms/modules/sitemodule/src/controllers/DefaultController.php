<?php
/**
 * Site Module - Frontend Controller
 *
 * Create any site specific frontend routes here
 */

namespace modules\sitemodule\controllers;

use craft\web\Controller;
use yii\web\Response;

/**
 * Default Controller
 *
 * Generally speaking, controllers are the middlemen between the front end of
 * the CP/website and your module’s services. They contain action methods which
 * handle individual tasks.
 *
 * A common pattern used throughout Craft involves a controller action gathering
 * post data, saving it on a model, passing the model off to a service, and then
 * responding to the request appropriately depending on the service method’s response.
 *
 * Action methods begin with the prefix “action”, followed by a description of what
 * the method does (for example, actionSaveIngredient()).
 *
 * https://craftcms.com/docs/plugins/controllers
 */
class DefaultController extends Controller
{
    /**
     * @var    bool|array Allows anonymous access to this controller's actions.
     *         The actions must be in 'kebab-case'
     * @access protected
     */
    protected array|bool|int $allowAnonymous = ['index'];


    /**
     * Handle a request going to our module's index action URL,
     * e.g.: actions/site-module/default
     *
     * @return Response
     */
    public function actionIndex(): Response {

        $variables = [

        ];

        return $this->renderTemplate('_sitemodule/index', $variables );
    }
}