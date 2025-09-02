# Craft CMS 5+ Local Module

Bare bones custom local module for Craft CMS 5.x projects


## Installation

### 1. Add entires to `modules` + `bootstrap` arrays in `config/app.php`:

```php
return [
    'modules' => [
        'local' => [
            'class' => \modules\local\LocalModule::class,
        ],
    ],
    'bootstrap' => ['local'],
];
```

### 2. Add `psr-4` autoload record in `composer.json`:

```json
    "autoload": {
        "psr-4": {
          "modules\\local\\": "modules/local/src/"
        }
    },
```

### 3. Rebuild Composer autoload map:

```bash
    composer dump-autoload
```