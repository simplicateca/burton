<?php
/**
 * ThemeCore - Control Panel Asset Bundle Loader
 */

namespace modules\themecore\assetbundles\themecore;

use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

class ThemeCoreAsset extends AssetBundle
{
    public function init(): void
    {
        $this->sourcePath = "@modules/themecore/assetbundles/themecore/dist";

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'js/ThemeCore-Admin.js',
        ];

        $this->css = [
            'css/ThemeCore-Admin.css',
        ];

        parent::init();
    }
}
