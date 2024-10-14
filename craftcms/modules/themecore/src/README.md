# Theme Core for Craft CMS 5.x

This module provides a base theme for Craft CMS 5.x projects, particularly those built with the Burton protosite.

## Installation

### 1. Add entires to `modules` + `bootstrap` arrays in `config/app.php`:

```php
return [
    'modules' => [
        'theme-core' => [
            'class' => \modules\themecore\ThemeCore::class,
        ],
    ],
    'bootstrap' => ['theme-core'],
];
```

### 2. Add `psr-4` autoload record in `composer.json`:

```json
    "autoload": {
        "psr-4": {
          "modules\\themecore\\": "modules/themecore/src/"
        }
    },
```

### 3. Rebuild Composer autoload map:

```bash
    composer dump-autoload
```