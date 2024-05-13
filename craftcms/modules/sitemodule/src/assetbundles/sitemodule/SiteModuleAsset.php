<?php
/**
 * SiteModule - Control Panel Asset Bundle Loader
 */

namespace modules\sitemodule\assetbundles\sitemodule;

use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

class SiteModuleAsset extends AssetBundle
{
    public function init(): void
    {
        $this->sourcePath = "@modules/sitemodule/assetbundles/sitemodule/dist";

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'js/SiteModule.js',
        ];

        $this->css = [
            'css/SiteModule.css',
        ];

        parent::init();
    }
}
