# Burton for Craft CMS 4+

Burton is a proto-website / starter kit for Craft CMS 4.

It excels at rapidly prototyping website structures + page layouts.

For more information visit: [buildwithburton.com](https://buildwithburton.com)
 

## Installation

You will need Docker desktop for your platform installed to run the project in local development.

1. Run the following command to create a new project:

	`composer create-project simplicateca/burton YOUR_PROJECT_NAME`

2. Change into the project directory and run this command to bring up the docker container for the first time:

	`make dev`

	This first launch will take several minutes to run while Docker does it's thing. Subsequent launches will be faster.


3. The webpack container will likely be the last to finish installing. Wait until you see this in the console:

```
webpack_1  | [nodemon] starting `webpack serve --config webpack.dev.js`
webpack_1  | <i> [webpack-dev-server] Project is running at:
webpack_1  | <i> [webpack-dev-server] Loopback: http://localhost:8080/
```

	And then visit the URL http://localhost:8000
  

## Admin Login

URL:  http://localhost:8000/admin

Login: `steve@simplicate.ca`

Password: `letmein`


## Important things to note

 - If you make a change to the contents of the `.env file` you will need to shutdown the docker container and restart it.

 - This project assumes you will be using an Amazon S3 or Digital Ocean Spaces type solution for storing your project assets in the cloud. You can disable this editing the `Asset Settings` or lean into it by editing the `CDN + S3 settings` section of the `.env` file to look something like:

```
    CDN_URL=https://[YOUR_BUCKET].[YOUR_REGION].digitaloceanspaces.com
    CDN_FOLDER=[asset/root/folder]
    S3_KEY=[...]
    S3_SECRET=[...]
    S3_ENDPOINT=https://[YOUR_REGION].digitaloceanspaces.com
    S3_BUCKET=[YOUR_BUCKET]
    S3_REGION=[YOUR_REGION]
```

 - If you attempt to export the Craft CMS database through the Admin > Utilities menu and receive an error message, run `make fixdb` and attempt the export again. This fixes a [weird mysql-server:8 bug](https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded) that only shows up when trying to export. This command only needs to be run once.