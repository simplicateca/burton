<?php

use craft\helpers\App;
use craft\config\GeneralConfig;

return GeneralConfig::create()

    // General Settings
    // ➜ https://craftcms.com/docs/5.x/reference/config/general.html
    ->maxUploadFileSize('100M')
    ->sendPoweredByHeader(false)
    ->omitScriptNameInUrls()
    ->preloadSingles()
    ->maxRevisions(10)
    ->runQueueAutomatically(false)
    ->errorTemplatePrefix( '_site/' )
    ->defaultCountryCode( App::env('CRAFT_COUNTRY') ?: 'US' )
    ->defaultCpLanguage( App::env('CRAFT_LANGUAGE') ?: 'en-US' )
    ->defaultCpLocale( App::env('CRAFT_LOCALE') ?: App::env('CRAFT_LANGUAGE') )
    ->defaultWeekStartDay(1)
    ->defaultSearchTermOptions([
        'subLeft'  => true,
        'subRight' => true,
    ])

    // Aliases
    // ➜ https://craftcms.com/docs/5.x/reference/config/general.html#aliases
    ->aliases([
        '@web'      => App::env('CRAFT_WEB_URL'),
        '@assets'   => App::env('MINIO_ENDPOINT'),
        '@automate' => App::env('AUTOMATE_ENDPOINT') . App::env('AUTOMATE_WEBHOOK_URL') ?? '/webhook-test',
        '@webroot'  => App::env('CRAFT_WEB_ROOT'),
        '@svg'      => App::env('CRAFT_WEB_URL') . '/dist/svg',
        '@svgroot'  => App::env('CRAFT_WEB_ROOT') . '/dist/svg',
        '@fonts'    => App::env('CRAFT_ENVIRONMENT') === 'dev'
                        ? App::env('VITE_DEV_SERVER_PUBLIC') . '/fonts'
                        : App::env('CRAFT_WEB_ROOT') . '/dist/fonts',
    ])

    // Admin Panel & DevMode Changes
    // ➜ https://craftcms.com/guides/what-dev-mode-does
    // ➜ https://craftcms.com/docs/5.x/reference/config/general.html#allowupdates
    ->allowUpdates(false)
    ->allowAdminChanges( (App::env('CRAFT_ENVIRONMENT') != 'production') )
    ->devMode( (App::env('CRAFT_ENVIRONMENT') != 'production') )
    ->disallowRobots( (App::env('CRAFT_ENVIRONMENT') != 'production') )

    // User Account Management
    // ➜ https://craftcms.com/docs/5.x/system/user-management.html
    // ➜ https://www.craftcms.com/knowledge-base/front-end-user-accounts
    ->useEmailAsUsername(true)
    ->deferPublicRegistrationPassword(true)
    ->autoLoginAfterAccountActivation(true)
    ->verifyEmailPath('account/verification')
    ->verifyEmailSuccessPath('account/verified')
    ->logoutPath('account/logout')
    ->loginPath('account/login')
    ->setPasswordRequestPath('account/forgot')
    ->setPasswordSuccessPath('account/reset')
;
