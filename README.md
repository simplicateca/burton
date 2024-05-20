# Burton for Craft CMS 5+

A proto-website / starter kit for [Craft CMS 5](https://craftcms.com/) that excels at rapidly prototyping deep, information rich websites. **Opinionated but flexible.**

Learn more at [buildwithburton.com ➜](https://buildwithburton.com)


## What is Burton?

Burton is a framework for modeling and architecting website content in a modern, sane, and designer/developer/editing/client friendly way. It is not a website-in-a-box, a universal page-builder, or a theme for Craft CMS.

Heavily influenced by the 80/20 principle, Burton streamlines some aspects of site development by implementing a robust "default" content model along with a set of lightweight Twig templates that support it.

This allows the design & development team to focus on the unique & challenging aspects of each project, rather than reinventing wheels.


## Requirements

### Local Development

Burton requires Docker for local development. Ensure that you have the latest version of [Docker Engine](https://docs.docker.com/engine/install/) installed on your development machine. Additionally, if you are already using DDEV for Craft site development, Burton can seamlessly run alongside your existing DDEV projects, as DDEV is built on top of Docker.

If you are a Windows user, having [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) installed can enhance your experience with the command-line `make` commands.

Please open an issue if you experience any issues getting the project up and running so that I can debug for other operating systems & setups.

## Craft Plugin Requirements

### Essential Plugins

Burton operates efficiently out-of-the-box with just a few essential Craft Plugins, each carefully selected to deliver core functionality.

While not so much *required*, these plugins are so strongly recommended that they might as well be required for all the trouble it would take not to use them.

You may of course add additional plugins as needed, but the following are required for Burton to function as intended:

**[SelectPlus](https://github.com/simplicateca/craft-selectplus-field)**

Also by Simplicate (the creator of Burton), SelectPlus is the only paid plugin essential for Burton to operate as *efficiently* as possible.

I say *efficiently* because, while it's hypothetically possible to omit SelectPlus, it would be at the detriment of layout flexibility, author-experience, and development speed.

Obviously I'm biased, but I also didn't want to give you the impression that SelectPlus is the only option for managing block-level design & layout tokens in Craft.

[Design Tokens by TrendyMinds](https://plugins.craftcms.com/designtokens), [LJ Dynamic Fields by Lewis Jenkins](https://plugins.craftcms.com/craft-dynamic-fields?craft5), and [Element Meta by BlueWhale](https://plugins.craftcms.com/entry-meta?craft5=) are three plugins that might also be able to work.

And of course you always have the option of rolling your own solution for the Variant / Layout / Theme attribute fields.


### Pre-Installed Plugins (FREE)

 - **[CKEditor](https://plugins.craftcms.com/ckeditor?craft5)**

This is installed by default, but you could just as easily use Redactor or any other rich-text field plugin available.

Probably even get by with using a Markdown field, through it would be at a loss of some functionality and author-experience.


 - **[Retcon](https://plugins.craftcms.com/retcon?craft5)**
 - **[Empty Coalesce](https://plugins.craftcms.com/empty-coalesce)**

These Twig helper plugins aren't *strictly required*, but there's really no reason you shouldn't already be using them on every project.

Plus I like them and removing all references to them through-out the codebase would be a pain.


 - **[Vite - by nystudio107](https://nystudio107.com/docs/vite/)**

This most excellent plugin is included by default, but I would only call it *required* if you plan on using Vite as your frontend build tool.

If you want to use something different, you're welcome to change it up -- or you can even use no frontend build tool at all (I too sometimes yearn for the simpler days of the web, back before webpack and npm; but then I remember IE5 and I'm like, "nah.").


### Suggested Plugins (FREE)

Configuration for these plugin is already included within Burton, but they are not installed by default.

- Feed Me
- topshelfcraft/environment-label
- verbb/knock-knock
- vaersaagod/dospaces (or something similar for asset management)


**Recommended PAID Plugins**

Configurations and presets for these plugins is already included within Burton, but they are not strictly speaking *required*.

You are welcome to use other plugins (or none at all) to accomplish the functionality each of them provides:

- SEOMatic
- Navigation
- Formie
- putyourlightson/craft-blitz
- putyourlightson/craft-sherlock



### Frontend Tools & Frameworks

#### CSS

Tailwind 3 (and PostCSS with Vite) are used for the default template style, but they aren't strictly required.

Great care has been taken to minimalize the usage of Tailwind within the core templates. Some class names linger, but they are replaceable.

The Tailwind Container Query plugin is also used quite extensively in the default site theme.


#### JavaScript

Alpine.js and htmx are used for client-side interactivity. They aren't strictly required, but you will have to roll several of your own components to replace the out-of-the-box versions of: modals, accordions, tabs, search fields, drop-downs, carousels, etc.

The default interactive components were built to be: accessibility, seo, performance, and customization friendly.

Additionallly there are examples of how to implement custom Vue.js components and Greensock JS animations within the Burton templates.

Both Vue and Greensock are included in the frontend `package.json` file, but like pretty much everything else, they aren't strictly required (unless you want the functionality they provide, then things get a little more strict).


#### Vite

As mentioned above in the plugin section, Burton comes preconfigured with Vite as the frontend build tool, but it's not a strict requirement and can be swapped out if needed.


While the wireframe layouts provided with Burton are designed to look and function well "out of the box," they are intentionally lightweight and minimal, allowing for easy customization using vanilla CSS, Sass, or alternative styling approaches.


### Asset Storage

Burton is configured to utilize Amazon S3 or an S3-compatible CDN for asset storage.

While this provides a sensible default for asset management, it is not a strict requirement, and asset storage can be reconfigured as needed.

#### Setup & Configuration

**Edit the following in `craftcms/.env`**

```
CDN_URL=https://[YOUR_BUCKET].[YOUR_REGION].digitaloceanspaces.com

CDN_FOLDER=[asset/root/folder]

S3_KEY=[...]

S3_SECRET=[...]

S3_ENDPOINT=https://[YOUR_REGION].digitaloceanspaces.com

S3_BUCKET=[YOUR_BUCKET]

S3_REGION=[YOUR_REGION]

```

Restart Docker after making changes to the `.env` file, they use the above fields to configure the asset volumes in the Craft admin interface.



### Build & Deployment

Burton includes [Atomic Build+Deploy scripts](https://nystudio107.com/blog/executing-atomic-deployments) for automated build and deployment processes.

These scripts are designed to work seamlessly with the CI/CD tool Buddy, which offers a free plan for users.

While the use of Buddy is not mandatory, the provided scripts can be easily adapted to accommodate most hosting setups, with separate scripts available for staging and production deployments.



## Installation

Use the following command to create and run a new Burton project:

```bash
composer create-project simplicateca/burton YOUR_PROJECT_NAME
cd YOUR_PROJECT_NAME
make dev
```

This process may take several minutes the first time you install a Burton project. Subsequent installations and load times will be faster once Docker images are cached locally.

On success, the console will output information on how to access the site and content administration panel like below:

```
status-1 | Your Docker Development Environment is Ready!
status-1 | _______________________________________________
status-1 |
status-1 | Frontend Website
status-1 | >> http://localhost:8000
status-1 |
status-1 | Craft CMS Admin
status-1 | >> http://localhost:8000/cms
status-1 | u: craft@example.com
status-1 | p: letmein
```

### Frontend Website

If all has gone well, the site frontend will now be available at: http://localhost:8000.

### CMS Access

The Craft CMS admin panel is accessible at http://localhost:8000/cms using the credentials: craft@example.com/letmein.


## Configuration

### Environment File

	`craftcms/.env`

Note: If you make a change to the contents of the `.env file` you will need to shutdown the docker container and restart it.


## Twig Templating



## How Do I ... ?

### Import / Export Database

### Manage Composer Packages

### Manage Frontend / Node Packages

### Push to Staging / Production



## Credits

Developed by [simplicate.ca](http://simplicate.ca).

Thanks to the team at Pixel & Tonic for their ongoing work on Craft CMS. Thanks also to [Andrew Welch](https://github.com/nystudio107/) for his [excellent blog posts](https://nystudio107.com/blog) and [plugins](https://nystudio107.com/plugins), which have been a source of inspiration and learning for many Craft developers.