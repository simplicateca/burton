# Gearbox

This module is a collection of functionality that burton makes use of. It satisfies a wide array of functionality, from new custom fields, to twig extensions, and redactor improvements.

## Installation

To install the module, follow these instructions.

First, you'll need to include the following in your `config/app.php` file:
```
return [
    'modules' => [
        'gearbox' => [
            'class' => \modules\gearbox\Gearbox::class,
        ],
    ],
    'bootstrap' => ['gearbox'],
];
```
You'll also need to make sure that you add the following to your project's `composer.json` file so that Composer can find your module:
```
    "autoload": {
        "psr-4": {
          "modules\\gearbox\\": "modules/gearbox/src/"
        }
    },
```
After you have added this, you will need to do:
```
    composer dump-autoload
```
 …from the project’s root directory, to rebuild the Composer autoload map. This will happen automatically any time you do a `composer install` or `composer update` as well.

If you are using the burton starter, all this has already been done for you.