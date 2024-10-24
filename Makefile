#--------------------------------------------------------------
# Craft CMS Project
#--------------------------------------------------------------
CRAFT_PATH		:= craftcms
ETC_PATH		:= etc
FRONTEND_PATH	:= frontend

ENV_PATH		:= $(CRAFT_PATH)/.env
SEED_PATH		:= $(ETC_PATH)/docker/seed

APP_ID			:= $(shell grep -E '^CRAFT_APP_ID=' $(ENV_PATH) | cut -d '=' -f 2)
PROJECT_NAME	:= $(if $(APP_ID),$(APP_ID),$(shell basename $(realpath $(dir $(CURDIR))/..)))

COMPOSE			:= docker compose --project-name $(PROJECT_NAME) --env-file $(ENV_PATH)
COMPOSE_UP		:= $(COMPOSE) up
COMPOSE_DOWN	:= $(COMPOSE) down
COMPOSE_REBUILD	:= $(COMPOSE) up --build --force-recreate
COMPOSE_ARGS	:= --rm --remove-orphans

EXEC_SSH		:= $(COMPOSE) run $(COMPOSE_ARGS) php /bin/bash
EXEC_CRAFT		:= $(COMPOSE) run $(COMPOSE_ARGS) php /app/craft
EXEC_NPM		:= $(COMPOSE) run $(COMPOSE_ARGS) frontend npm
EXEC_COMPOSER	:= $(COMPOSE) run $(COMPOSE_ARGS) composer


# Actions
#--------------------------------------------------------------
.PHONY: assets backup composer craft debug dev down \
		npm nuke rebuild ssh update wipe
#--------------------------------------------------------------
assets: craft-index-assets
backup: craft-export
composer:
	@$(EXEC_COMPOSER) --optimize-autoloader $(CLI_ARGS) ;
craft:
	@$(EXEC_CRAFT) $(CLI_ARGS) ;
debug:
	@$(COMPOSE) --profile debug up ;
dev: setup
	@$(COMPOSE_UP) ;
down:
	@$(COMPOSE_DOWN) ;
npm:
	@$(EXEC_NPM) $(CLI_ARGS) ;
nuke: composer-wipe npm-wipe
	@$(COMPOSE_DOWN) -v ;
rebuild: setup
	@$(COMPOSE_REBUILD) ;
restart: down rebuild
ssh:
	@$(EXEC_SSH) ;
update: composer-bump restart
wipe: composer-wipe npm-wipe restart
setup:
	cp -n $(CRAFT_PATH)/example.env $(ENV_PATH)
	@if [ -z "$(APP_ID)" ]; then \
		sed -i "s|^CRAFT_APP_ID *= *.*|CRAFT_APP_ID=\"$(PROJECT_NAME)\"|" "$(ENV_PATH)"; \
	fi

	@if [ -f "$(SEED_PATH).sql.gz" ]; then \
		mkdir -p $(SEED_PATH) && gzip -dkc $(SEED_PATH).sql.gz > $(SEED_PATH)/craft.sql
	fi

#--------------------------------------------------------------
# Composer Shortcuts
#--------------------------------------------------------------
composer-bump: composer-update
	@$(EXEC_COMPOSER) bump ;
composer-update:
	@$(EXEC_COMPOSER) --optimize-autoloader update ;
composer-wipe:
	@rm -f $(CRAFT_PATH)/composer.lock
	@rm -rf $(CRAFT_PATH)/vendor

#--------------------------------------------------------------
# Craft Shortcuts
#--------------------------------------------------------------
craft-index-assets:
	@$(EXEC_CRAFT) index-assets/all ;
craft-export:
	$(EXEC_CRAFT) db/backup ;
craft-fresh-database:
	@$(EXEC_CRAFT) db/drop-all-tables --interactive=0 ;
	@$(EXEC_CRAFT) install/craft \
		--email='craft@example.com' \
		--password='letmein' \
		--site-name='Website' \
		--language='en-CA' \
		--site-url='http://localhost:8000' \
		--interactive=0 ;
craft-reseed: craft-export
	@rm -f $(SEED_PATH).sql.gz
	@cp -p "`ls -dtr1 $(CRAFT_PATH)/storage/backups/* | tail -1`" $(SEED_PATH).sql
	@gzip -c $(SEED_PATH).sql > $(SEED_PATH).sql.gz


# Object Storage Shortcuts
#--------------------------------------------------------------
minio-setup:
	@$(COMPOSE_UP) minio -d ;
	@sleep 3
	@mc mb localhost/${S3_BUCKET}
	@mc anonymous set download localhost/${S3_BUCKET}/public
	@$(COMPOSE_DOWN) ;

minio-staging-to-dev:
	@$(COMPOSE_UP) minio -d ;
	@sleep 3
	@mc mirror --overwrite staging/${STAGING_BUCKET}/public/content/staging localhost/${S3_BUCKET}/public/content/dev
	@mc mirror --overwrite staging/${STAGING_BUCKET}/public/design localhost/${S3_BUCKET}/public/design
	@mc mirror --overwrite staging/${STAGING_BUCKET}/private localhost/${S3_BUCKET}/private
	@$(COMPOSE_DOWN) ;

minio-dev-to-staging:
	@$(COMPOSE_UP) minio -d ;
	@sleep 3
	@mc mirror --overwrite localhost/${S3_BUCKET}/public/content/dev staging/${STAGING_BUCKET}/public/content/staging
	@mc mirror --overwrite localhost/${S3_BUCKET}/public/design staging/${STAGING_BUCKET}/public/design
	@mc mirror --overwrite localhost/${S3_BUCKET}/private staging/${STAGING_BUCKET}/private
	@$(COMPOSE_DOWN) ;


# NPM Shortcuts
#--------------------------------------------------------------
npm-wipe:
	@rm -f $(FRONTEND_PATH)/package-lock.json
	@rm -rf $(FRONTEND_PATH)/node_modules


# Read missing variables from .env file
#--------------------------------------------------------------
ifneq (,$(wildcard $(ENV_PATH)))
    include $(ENV_PATH)
    export $(shell sed 's/=.*//' $(ENV_PATH))
endif
#--------------------------------------------------------------

# Allow argument to be passed into the Makefile from the CLI
# ➜ https://stackoverflow.com/questions/6273608/
#--------------------------------------------------------------
CLI_ARGS=$(filter-out $@,$(MAKECMDGOALS))
%:
	@:
#--------------------------------------------------------------