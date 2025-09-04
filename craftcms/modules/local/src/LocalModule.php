<?php

namespace modules\local;

use Craft;
use yii\base\Module;
use modules\local\LocalAssetBundle;

class LocalModule extends Module
{
    protected ?string $_moduleAlias = '@modules/local';

    public function init(): void
    {
        parent::init();

        // Point alias at your dist/ folder (where fonts, SVGs, etc. live)
        Craft::setAlias('@local', __DIR__ . '/web/dist');

        // // If you want the entire module folder too:
        // Craft::setAlias('@mymodule', __DIR__);

        if ($this->_moduleAlias) {
            Craft::setAlias($this->_moduleAlias, $this->getBasePath());
        }

        if ( Craft::$app->getRequest()->getIsSiteRequest() ) {
            Craft::$app->getView()->registerAssetBundle( LocalAssetBundle::class );
        }

        // if ( Craft::$app->getRequest()->getIsCpRequest() ) {
        //     Craft::$app->getView()->registerAssetBundle( LocalAssetBundle::class );
        // }
        // $this->cpAssetBundles();
    }


    // private function cpAssetBundles(): void
    // {
    //     if (Craft::$app->getRequest()->getIsCpRequest() && !empty($this->_cpAssetBundles)) {
    //         Event::on(View::class, View::EVENT_BEFORE_RENDER_TEMPLATE, function (\craft\events\TemplateEvent $event) {
    //             foreach ($this->_cpAssetBundles as $bundle) {
    //                 try {
    //                     Craft::$app->getView()->registerAssetBundle($bundle);
    //                 } catch (InvalidConfigException $e) {
    //                     Craft::error('Error registering AssetBundle - ' . $e->getMessage(), __METHOD__);
    //                 }
    //             }
    //         });
    //     }
    // }

}
