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

If you the `make` command isn't available (Windows?) you can achieve the same thing by running the command:

    `docker-compose up`


3. The Vite container will likely be the last to finish installing. Wait until you see this in the console:

```
vite_1   |   vite v2.9.15 dev server running at:
vite_1   |
vite_1   |   > Local:    http://localhost:3000/
vite_1   |   > Network:  http://192.168.96.5:3000/

```

	And then visit the URL http://localhost:8000


## Admin Login

URL:  http://localhost:8000/admin

Login: `craft-admin@example.com`

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