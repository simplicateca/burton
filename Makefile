##----------------------------------------------------------- ##
## Craft CMS Project Makefile
##----------------------------------------------------------- ##
.PHONY: preflight dev debug down ssh craft craft-index-assets \
		craft-export craft-drop-database craft-install craft-fresh-database \
		craft-reseed composer composer-bump composer-update composer-wipe \
		npm yarn frontend-wipe n8n-import n8n-export npm-wipe

## Essential Variables
##----------------------------------------------------------- ##
CRAFT_FOLDER   ?= ./craftcms
CRAFT_ENV      ?= $(CRAFT_FOLDER)/.env
CRAFT_SQL_SEED ?= $(CRAFT_FOLDER)/seed.sql.gz
CLI_ARGS       := $(filter-out $@,$(MAKECMDGOALS))

## Load .env if it exists
##----------------------------------------------------------- ##
ifneq (,$(wildcard $(CRAFT_ENV)))
    include $(CRAFT_ENV)
    export $(shell sed -n 's/^\([^#][^=]*\)=.*/\1/p' $(CRAFT_ENV))
endif

## Helper: ensure env var exists in $(ENV_PATH)
##----------------------------------------------------------- ##
define ensure-env
	echo "Ensuring $(1) is set and not empty in $(CRAFT_ENV)"
	@if ! grep -q '^$(1)=' $(CRAFT_ENV) 2>/dev/null; then \
		val="$(2)"; \
		echo "$(1)=$$val" >> $(CRAFT_ENV); \
		export $(1)="$$val"; \
		echo "[INFO] Added $(1)=$$val to $(CRAFT_ENV)"; \
	elif [ -z "$$(grep '^$(1)=' $(CRAFT_ENV) | cut -d'=' -f2-)" ]; then \
		val="$(2)"; \
		sed -i "s/^$(1)=.*/$(1)=$$val/" $(CRAFT_ENV); \
		export $(1)="$$val"; \
		echo "[INFO] Updated $(1) to $$val in $(CRAFT_ENV)"; \
	fi
endef

## Preflight: copy .env.example and restore seed
##----------------------------------------------------------- ##
preflight:
	@cp -n $(CRAFT_FOLDER)/.env.example $(CRAFT_ENV) || true
	@$(call ensure-env,CRAFT_APP_ID,Craft-$(shell (command -v uuidgen >/dev/null && uuidgen) || cat /dev/urandom | tr -dc 'a-f0-9' | head -c 32))
	@if [ -f "$(CRAFT_SQL_SEED)" ]; then \
		mkdir -p $(CRAFT_FOLDER)/storage/seed && \
		gzip -dkc $(CRAFT_SQL_SEED) > $(CRAFT_FOLDER)/storage/seed/craft.sql; \
		echo "[INFO] Seed file restored to storage/seed/craft.sql"; \
	fi

## Init: Generate CRAFT_APP_ID if missing
##----------------------------------------------------------- ##
init: preflight


## Docker Shortcuts
##----------------------------------------------------------- ##
COMPOSE := docker compose --project-name $(shell echo $(CRAFT_APP_ID) | tr '[:upper:]' '[:lower:]') --env-file $(CRAFT_ENV)

dev: preflight
	@$(COMPOSE) up ;
debug: preflight
	@$(COMPOSE) --profile debug up ;
down:
	@$(COMPOSE) down $(CLI_ARGS) ;
ssh:
	@$(COMPOSE) run --rm --remove-orphans php /bin/bash ;


## Craft CMS
##----------------------------------------------------------- ##
craft: preflight
	@$(COMPOSE) run --rm --remove-orphans php /app/craft $(CLI_ARGS) ;

craft-index-assets: preflight
	@$(COMPOSE) run --rm --remove-orphans php /app/craft index-assets/all ;

craft-export: preflight
	@$(COMPOSE) run --rm --remove-orphans php /app/craft db/backup ;

craft-drop-database: preflight
	@$(COMPOSE) run --rm --remove-orphans php /app/craft db/drop-all-tables --interactive=0 ;

craft-install:
	@rm -f $(CRAFT_FOLDER)/storage/seed/*.sql $(CRAFT_FOLDER)/storage/seed/*.gz $(SEED_FILE)
	@$(COMPOSE) run --rm --remove-orphans php /app/craft install/craft \
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
PHP_COMPOSER = $(COMPOSE) run --rm --remove-orphans composer --no-interaction

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
	@$(COMPOSE) run --rm --remove-orphans frontend npm $(CLI_ARGS) ;

yarn:
	@$(COMPOSE) run --rm --remove-orphans frontend yarn $(CLI_ARGS) ;

frontend-wipe:
	@rm -rf frontend/node_modules frontend/package-lock.json frontend/yarn.lock || true



## n8n Commands
##----------------------------------------------------------- ##
# https://docs.n8n.io/hosting/cli-commands/#import-workflows-and-credentials
n8n-import:
	$(RUN_N8N) import:workflow --separate --input=/home/node/n8n/workflows ;
	$(RUN_N8N) import:credentials --separate --input=/home/node/n8n/credentials ;

# https://docs.n8n.io/hosting/cli-commands/#export-workflows-and-credentials
n8n-export:
	$(RUN_N8N) export:workflow --backup --output=/home/node/n8n/workflows ;
	$(RUN_N8N) export:credentials --backup --output=/home/node/n8n/credentials ;



## Allow argument to be passed into the Makefile from the CLI
## ➜ https://stackoverflow.com/questions/6273608/
##----------------------------------------------------------- ##
%:
	@:
##----------------------------------------------------------- ##