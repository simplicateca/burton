<?php

namespace modules\sitemodule\models;

use Craft;
use craft\base\Model;

/**
 * Reference Model model
 */
class ReferenceModel extends Model
{
    protected function defineRules(): array
    {
        return array_merge(parent::defineRules(), [
            // ...
        ]);
    }
}
