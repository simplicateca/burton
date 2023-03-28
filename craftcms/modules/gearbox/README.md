# Gearbox Module

A collection of functionality bits common to all Burton Starter projects.

Ideally you should use this module to add functionality you want to re-use across multiple projects.

Don't go out of your way to avoid making small edits to this module if it makes life easier / faster. It's not a plugin for a reason.

But the majority of site-specific functionality should be added to the default custom module `modules/sitemodule` or a new module.  


## What's in the box?
  
### New Twig Functions

#### normalizeBlocks( entry.matrixBuilder.all() )

Probably the most significant of all included twig extensions.

Mostly a convenience function to help organize the contents of a Content Builder field before passing it through the loop.

This functionality could be handled in twig, but the code is really clunky and makes the loop unreadable and hard to follow.

	See: `templates/_builders/_loop.twig`

**Primary functionality**

- Merges the settings & properties of the 3 common block-level formatting fields (variant/background/spacing) into a single hash.
- Pre-splices fragment blocks (particularly multi-block fragments) into the builder loop to simplify block-level rendering templates.

	See: `templates/_builders/_block.twig`


#### embedInfo

Mimics the basic functionality of the [oEmbed plugin](https://github.com/wrav/oembed/blob/master/README.md). Parses external URLs for meta information and inline iframe embed instructions.

Works for:

- YouTube
- Vimeo
- Spotify
- SoundCloud 
- Twitter 
- Giphy
- Reddit
- Codepen

Full list: https://github.com/ricardofiorani/oembed


#### firstHref

Evaluates a string of HTML to see if a link (`<a href=""></a>`) appears before any other plain text. If it does, output the value of the `href` tag.



### New Twig Filters

#### extractLeadingHeaders

Removes everything from a string (typically the contents of a Redactor field) of HTML *except* for any h1...h6 tags that appear above any other type of content (p, li, a, div, etc).

	{% set leadingHeaders = block.text|extractLeadingHeader %}

These are considered the *Leading Headers* of a text block.

This filter is typically called to output the Leading Headers (as a group) in a different position within the HTML hierarchy of a block.

The separation of any Leading Headers from the rest of the block content allows for a more diverse range of block layouts without overly complicating the content editing interface.


#### removeLeadingHeaders

Does the opposite of `extractLeadingHeaders` so that you can out the rest of the block content without any Leading Headers (assuming they've moved to a different part of the block layout)

	{% set leftoverText = block.text|removeLeadingHeaders %}


#### extractTrailingButtons


#### removeTrailingButtons


#### hex2rgb


#### groupButtons


#### statFormat


### Redactor Adjustments


### Craft Matrix CSS Stylesheets


### HTML Purifier Adjustments

Allow the following attributes to appear on `<a>` tags:

- aria-label
- data-ident
- data-modal

This allows the Redactor Link Attributes plugin to provide an interface for content editors to manage those fields.


### User Permission Group for Sitebook Access


### Sidebar Entry Types

A modified implementation of the [Sidebar Entry Types Plugin](https://github.com/ethercreative/sidebar-entrytypes) by Ether Creative, with some additional JavaScript micro-improvements to the Craft UI when interacting with Sidebar sub-sections.


## Installation

If you are using the Burton Starter, the following steps are not necessary. The Gearbox module is already a default part of Burton.

To install this module outside of a Burton Starter, following these steps:

Include the following in your `config/app.php` file:

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

…from the project’s root directory, to rebuild the Composer autoload map. This will happen automatically any time you do a `composer install` or `composer update` as well.>)