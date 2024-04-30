#!/bin/sh

cat << EOF
     _                 _ _           _
 ___(_)_ __ ___  _ __ | (_) ___ __ _| |_ ___
/ __| | '_ \` _ \| '_ \| | |/ __/ _\` | __/ _ \\
\__ \ | | | | | | |_) | | | (_| (_| | ||  __/
|___/_|_| |_| |_| .__/|_|_|\___\__,_|\__\___|
                |_|

Your Docker Development Environment is Ready!
_______________________________________________

Frontend Website
 >> http://localhost:8000

Craft CMS Admin
 >> http://localhost:8000/${CRAFT_CP_TRIGGER:-admin}
 u: craft@example.com
 p: letmein

Editor Facing Style/Layout/Component Guide
 >> http://localhost:8000/sitehub

Development Documentation Wiki
 >> http://localhost:5000

EOF

# test env variables
echo " "
echo "Checking ./craftcms/.env for missing variables"
echo "-----------------------------------------------"
[[ ! -z "$S3_KEY" ]]          || echo " ! S3_KEY          ... missing!"
[[ ! -z "$S3_SECRET" ]]       || echo " ! S3_SECRET       ... missing!"
[[ ! -z "$CAPTCHA_KEY" ]]     || echo " ! CAPTCHA_KEY     ... missing!"
[[ ! -z "$CAPTCHA_SECRET" ]]  || echo " ! CAPTCHA_SECRET  ... missing!"
[[ ! -z "$SMTP_USERNAME" ]]   || echo " ! SMTP_USERNAME   ... missing!"
[[ ! -z "$SMTP_PASSWORD" ]]   || echo " ! SMTP_PASSWORD   ... missing!"
[[ ! -z "$SMTP_HOSTNAME" ]]   || echo " ! SMTP_HOSTNAME   ... missing!"




echo " "