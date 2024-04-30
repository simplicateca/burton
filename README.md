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

### Craft Plugins

Burton operates efficiently with just a few essential Craft Plugins, meticulously chosen to deliver core functionality.

**Required Craft CMS Plugins**

  - [CKEditor](https://plugins.craftcms.com/ckeditor?craft5)
  - [SelectPlus](https://github.com/simplicateca/craft-selectplus-field)
  - [Retcon](https://plugins.craftcms.com/retcon?craft5)
  - [Empty Coalesce](https://plugins.craftcms.com/empty-coalesce)
  - nystudio107/craft-closure
  - Sprig
  - Vite

While these plugins are included by default, users have the freedom to tailor their toolkit by adding optional plugins as needed.

**Recommended Craft CMS Plugins**

- Feed Me
- SEOMatic
- Formie
- Navigation
- putyourlightson/craft-blitz
- putyourlightson/craft-sherlock
- topshelfcraft/environment-label
- vaersaagod/dospaces
- verbb/knock-knock


### Frontend Tools & Frameworks

While Burton comes preconfigured with Vite as the frontend build tool, it's important to note that Vite is not a strict requirement and can be swapped out if needed.

Additionally, Tailwind 3, along with PostCSS and the Tailwind Container Queries plugin, are utilized for styling.

While the wireframe layouts provided with Burton are designed to look and function well "out of the box," they are intentionally lightweight and minimal, allowing for easy customization using vanilla CSS, Sass, or alternative styling approaches.


### Asset Storage

Burton is configured to utilize Amazon S3 or an S3-compatible CDN for asset storage.

While this provides a sensible default for asset management, it is not a strict requirement, and asset storage can be reconfigured as needed.


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


### Asset Object Storage / CDN

Edit the following in `craftcms/.env`

```
CDN_URL=https://[YOUR_BUCKET].[YOUR_REGION].digitaloceanspaces.com

CDN_FOLDER=[asset/root/folder]

S3_KEY=[...]

S3_SECRET=[...]

S3_ENDPOINT=https://[YOUR_REGION].digitaloceanspaces.com

S3_BUCKET=[YOUR_BUCKET]

S3_REGION=[YOUR_REGION]

```


## How Do I ... ?

### Import / Export Database

### Manage Composer Packages

### Manage Frontend / Node Packages

### Push to Staging / Production



## Credits

Developed by [simplicate.ca](http://simplicate.ca).

Thanks to the team at Pixel & Tonic for their ongoing work on Craft CMS. Thanks also to [Andrew Welch](https://github.com/nystudio107/) for his [excellent blog posts](https://nystudio107.com/blog) and [plugins](https://nystudio107.com/plugins), which have been a source of inspiration and learning for many Craft developers.