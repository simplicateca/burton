<?php

namespace modules\local;

use craft\web\AssetBundle;

class LocalAssetBundle extends AssetBundle
{
    public function init(): void
    {
        $this->sourcePath = "@modules/local/web/static";
        // $this->css = ["css/styles.css"];
        // $this->js = ["js/script.js"];
        parent::init();
    }
}
