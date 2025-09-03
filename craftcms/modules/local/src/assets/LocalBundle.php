<?php

namespace modules\local\assets;

use craft\web\AssetBundle;

class LocalBundle extends AssetBundle
{
    public function init(): void
    {
        $this->sourcePath = "@modules/local/assets/dist";
        // $this->css = ["css/styles.css"];
        // $this->js = ["js/script.js"];
        parent::init();
    }
}
