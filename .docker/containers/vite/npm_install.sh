#!/bin/bash

# NPM Install shell script
#
# This shell script runs `npm install` if either the `package-lock.json` file or
# the `node_modules/` directory is not present`
#
# @author    nystudio107
# @copyright Copyright (c) 2022 nystudio107
# @link      https://nystudio107.com/
# @license   MIT

cd /var/www/project/src
if [ ! -f "package-lock.json" ] || [ ! -d "node_modules/vite" ]; then
    npm install
fi
chmod -R 0777 /var/www/project/src/node_modules
chmod 0777 /var/www/project/src/package-lock.json
