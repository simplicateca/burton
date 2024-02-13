<?php
/**
 * SiteModule - Custom twig filters and functions for this site
 */

namespace modules\sitemodule\twigextensions;

use modules\sitemodule\SiteModule;

use Craft;
use craft\elements\Entry;

use Twig\TwigFilter;
use Twig\TwigFunction;
use Twig\Extension\AbstractExtension;

class SiteModuleTwig extends AbstractExtension
{

    public function getName(): string
    {
        return 'SiteModule';
    }

    public function getFilters(): array
    {
        return [

        ];
    }

    public function getFunctions(): array
    {
        return [

        ];
    }

}
