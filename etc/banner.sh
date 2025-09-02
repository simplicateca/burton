#!/bin/sh

cat << EOF
 _           _
| |_ _ _ ___| |_ ___ ___
| . | | |  _|  _| . |   |
|___|___|_| |_| |___|_|_|
_______________________________________________

Website Frontend
 ➜ http://localhost:8000

Craft CMS Admin
 ➜ http://localhost:8000/${CRAFT_CP_TRIGGER:-admin}
🥷  craft@example.com
🔒 letmein

n8n Workflow Automation
 ➜ http://localhost:5678
🥷  n8n@example.com
🔒 letmein

MinIO Object Storage
 ➜ http://localhost:9001
🥷  ${S3_ACCESS_KEY:-project}
🔒 ${S3_SECRET_KEY:-secretkey}

Mailhog Email Testing
 ➜ http://localhost:8025

_______________________________________________

EOF

# test env variables
echo " "
echo "Checking ./craftcms/.env for missing variables"
echo "-----------------------------------------------"
[[ ! -z "$S3_ACCESS_KEY" ]]   || echo " ! S3_ACCESS_KEY   ... missing!"
[[ ! -z "$S3_SECRET_KEY" ]]   || echo " ! S3_SECRET_KEY   ... missing!"
[[ ! -z "$CAPTCHA_KEY" ]]     || echo " ! CAPTCHA_KEY     ... missing!"
[[ ! -z "$CAPTCHA_SECRET" ]]  || echo " ! CAPTCHA_SECRET  ... missing!"
[[ ! -z "$EMAIL_HOSTNAME" ]]  || echo " ! EMAIL_HOSTNAME  ... missing!"
[[ ! -z "$EMAIL_USERNAME" ]]  || echo " ! EMAIL_USERNAME  ... missing!"
[[ ! -z "$EMAIL_PASSWORD" ]]  || echo " ! EMAIL_PASSWORD  ... missing!"

echo " "