<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

use craft\config\GeneralConfig;
use craft\helpers\App;

return GeneralConfig::create()
    // Enable Dev Mode (see https://craftcms.com/guides/what-dev-mode-does)
    ->devMode( (App::env('CRAFT_ENVIRONMENT') != 'production') )

    // run the queue automatically (or do we have a cron job setup)
    ->runQueueAutomatically( ( App::env('CRAFT_RUN_QUEUE_AUTOMATICALLY') ) )

    // Allow administrative changes
    ->allowAdminChanges( (App::env('CRAFT_ENVIRONMENT') != 'production') )

    // Only allow plugin / Craft updates through the command line
    // https://craftcms.com/docs/4.x/config/general.html#allowupdates
    ->allowUpdates(false)

    // Enable Caching
    ->enableTemplateCaching( (App::env('CRAFT_ENVIRONMENT') == 'production') )

    // Disallow robots
    ->disallowRobots( (App::env('CRAFT_ENVIRONMENT') != 'production') )

    // Don't announce CMS
    // https://craftcms.com/docs/4.x/config/general.html#sendpoweredbyheader
    ->sendPoweredByHeader(false)

    // aliases for s3 / object storage assets
    ->aliases([
        '@cdn'    => App::env('CDN_FOLDER'),
        '@web'    => App::env('CRAFT_WEB_URL'),
        '@webroot'=> App::env('CRAFT_WEB_ROOT'),
    ])

    // Set the default week start day for date pickers (0 = Sunday, 1 = Monday, etc.)
    ->defaultWeekStartDay(1)

    // Prevent generated URLs from including "index.php"
    ->omitScriptNameInUrls()

    // improve save speed by limiting the number of revisions we save
    ->maxRevisions(10)

    ->defaultSearchTermOptions([
        'subLeft'  => true,
        'subRight' => true,
    ])

    // 100MB
    ->maxUploadFileSize('100M')

    // let users sign-up with just an email and set a password after email confirmation
    // https://craftcms.com/docs/4.x/config/general.html#deferpublicregistrationpassword
    ->deferPublicRegistrationPassword(true)

    ->useEmailAsUsername(true)

    ->autoLoginAfterAccountActivation(true)

    ->loginPath( '/account' )
;
