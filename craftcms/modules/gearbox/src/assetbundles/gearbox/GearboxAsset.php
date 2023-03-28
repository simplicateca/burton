<?php
/**
 * Gearbox - Asset Bundle
 *
 * Mostly minor css/js tweaks for redactor
 * and Craft matrix blocks.
 */

namespace modules\gearbox\assetbundles\gearbox;

use Craft;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

class GearboxAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init(): void
    {
        $this->sourcePath = "@modules/gearbox/assetbundles/gearbox/dist";

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'js/Gearbox.js',
        ];

        $this->css = [
            'css/Gearbox.css',
        ];

        parent::init();
    }
}
