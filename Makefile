.PHONY: dev debug dev-down ssh craft craft-index-assets \
		craft-export craft-drop-database craft-install craft-fresh-database \
		craft-reseed composer composer-bump composer-update composer-wipe \
		npm yarn frontend-wipe n8n-import n8n-export npm-wipe


# Load variables from .env
ifneq (,$(wildcard .env))
include .env
export
endif

# Command Line Arguments
CLI_ARGS   := $(filter-out $@,$(MAKECMDGOALS))
CLI_ARGS   := $(wordlist 2,$(words $(CLI_ARGS)),$(CLI_ARGS))

# Preflight Hack
CRAFT_ENV  := $(shell [ -f craftcms/.env.example ] && cp -n craftcms/.env.example craftcms/.env || true)
SEED_DIR   := $(shell mkdir -p ./etc/mysql)
SEED_CRAFT := $(shell [ -f ${CRAFT_DB_SEED} ] && gzip -dkc $(CRAFT_DB_SEED) > ./etc/mysql/craft-seed.sql || true)


## Docker Shortcuts
##----------------------------------------------------------- ##
dev:
	@docker compose up ;
debug:
	@docker compose --profile debug up ;
dev-down:
	@docker compose down ;
dev-nuke:
	@docker compose down -v --remove-orphans ;
ssh:
	@docker compose run --rm --remove-orphans php /bin/bash ;


## Craft CMS
##----------------------------------------------------------- ##
craft:
	@docker compose run --rm --remove-orphans php /app/craft $(CLI_ARGS) ;

craft-index-assets:
	@docker compose run --rm --remove-orphans php /app/craft index-assets/all ;

craft-export:
	@docker compose run --rm --remove-orphans php /app/craft db/backup $(CLI_ARGS) --interactive=0 ;

craft-drop-database:
	@docker compose run --rm --remove-orphans php /app/craft db/drop-all-tables --interactive=0 ;

craft-install:
	@docker compose run --rm --remove-orphans php /app/craft install/craft \
		--email='craft@example.com' \
		--password='letmein' \
		--site-name='English' \
		--language='en-CA' \
		--site-url='http://localhost:8000/en' \
		--interactive=0 ;

craft-fresh-database: craft-drop-database craft-install

craft-reseed: craft-export
	@mkdir -p $(CRAFT_FOLDER)/storage/seed
	@rm -f $(CRAFT_FOLDER)/storage/seed/*.sql $(CRAFT_FOLDER)/storage/seed/*.gz $(SEED_FILE)
	@cp -p "`ls -dtr1 $(CRAFT_FOLDER)/storage/backups/* | tail -1`" $(CRAFT_FOLDER)/storage/seed/temp.sql
	@gzip -c $(CRAFT_FOLDER)/storage/seed/temp.sql > $(SEED_FILE)


## PHP Composer
##----------------------------------------------------------- ##
PHP_COMPOSER=docker compose run --rm --remove-orphans composer --no-interaction

composer:
	@$(PHP_COMPOSER) $(CLI_ARGS) ;

composer-bump: composer-update
	@$(PHP_COMPOSER) bump ;

composer-update:
	@$(PHP_COMPOSER) --optimize-autoloader update ;

composer-wipe:
	@rm -rf $(CRAFT_FOLDER)/vendor $(CRAFT_FOLDER)/composer.lock || true


## Frontend Build Tools
##----------------------------------------------------------- ##
npm:
	@docker compose run --rm --remove-orphans frontend npm $(CLI_ARGS) ;

yarn:
	@docker compose run --rm --remove-orphans frontend yarn $(CLI_ARGS) ;

frontend-wipe:
	@rm -rf frontend/node_modules frontend/package-lock.json frontend/yarn.lock || true



## n8n Commands
##----------------------------------------------------------- ##
# https://docs.n8n.io/hosting/cli-commands/#import-workflows-and-credentials
n8n-import:
	@docker compose run --rm --remove-orphans n8n import:workflow --separate --input=/home/node/n8n/workflows ;
	@docker compose run --rm --remove-orphans n8n import:credentials --separate --input=/home/node/n8n/credentials ;

# https://docs.n8n.io/hosting/cli-commands/#export-workflows-and-credentials
n8n-export:
	@docker compose run --rm --remove-orphans n8n export:workflow --backup --output=/home/node/n8n/workflows ;
	@docker compose run --rm --remove-orphans n8n export:credentials --backup --output=/home/node/n8n/credentials ;



## Allow argument to be passed into the Makefile from the CLI
## ➜ https://stackoverflow.com/questions/6273608/
##----------------------------------------------------------- ##
%:
	@:
##----------------------------------------------------------- ##