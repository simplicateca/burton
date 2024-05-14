# Site module for Craft CMS 5.x

Use this module to add any custom logic for this project

To install the module, follow these instructions.

First, you'll need to include the following in your `config/app.php` file:
```
return [
    'modules' => [
        'sitemodule' => [
            'class' => \modules\sitemodule\SiteModule::class,
        ],
    ],
    'bootstrap' => ['site-module'],
];
```
You'll also need to make sure that you add the following to your project's `composer.json` file so that Composer can find your module:
```
    "autoload": {
        "psr-4": {
          "modules\\sitemodule\\": "modules/sitemodule/src/"
        }
    },
```
After you have added this, you will need to do:
```
    composer dump-autoload
```
 …from the project’s root directory, to rebuild the Composer autoload map. This will happen automatically any time you do a `composer install` or `composer update` as well.

If you are using the burton starter, all this has already been done for you.