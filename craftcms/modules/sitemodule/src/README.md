# SiteModule

Bare bones custom module for Craft CMS 5.x projects

Includes sample for custom routing, controllers, console commands, and twig extensions

## Installation

### 1. Add entires to `modules` + `bootstrap` arrays in `config/app.php`:

```php
return [
    'modules' => [
        'site-module' => [
            'class' => \modules\sitemodule\SiteModule::class,
        ],
    ],
    'bootstrap' => ['site-module'],
];
```

### 2. Add `psr-4` autoload record in `composer.json`:

```json
    "autoload": {
        "psr-4": {
          "modules\\sitemodule\\": "modules/sitemodule/src/"
        }
    },
```

### 3. Rebuild Composer autoload map:

```bash
    composer dump-autoload
```