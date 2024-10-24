#--------------------------------------------------------------
# Craft CMS Project
#--------------------------------------------------------------
CRAFT=craftcms
DOCKER=etc/docker
FRONTEND=frontend
STORAGE=$(CRAFT)/storage

# Environment
ENV=$(CRAFT)/.env
ENV_EMPTY=$(CRAFT)/example.env
ENV_ID=CRAFT_APP_ID
ENV_COPY=$(shell cp -n $(ENV_EMPTY) $(ENV) || true)

# Utilities
RAND_16=$(shell head /dev/urandom | tr -dc a-z0-9 | head -c 16)

# Database Seed
SEED_PATH=$(DOCKER)/seed
SEED_GZIP=$(DOCKER)/seed.sql.gz
SEED_UNZIP=$(shell mkdir -p $(SEED_PATH) && gzip -dkc $(SEED_GZIP) > $(SEED_PATH)/craft.sql || true)
# SEED_NAME=$(DOCKER)/Craft-$(date %Y-%m-%d-%H%M).sql
# SEED_TEST=$(shell [ -f $(SEED_GZIP) ] && [ ! -d $(SEED_PATH) ] && $(SEED_UNZIP) || true)

# Project
APP_ID=$(shell grep -E '^$(ENV_ID)=' $(ENV) | cut -d '=' -f 2)
PROJECT_NAME=$(if $(APP_ID),$(APP_ID),$(shell basename $(realpath $(dir $(CURDIR))/..)))
PROJECT_URL=$(shell grep -E '^CRAFT_WEB_URL=' $(ENV) | cut -d '=' -f 2)


# Docker Compose
COMPOSE=docker compose --project-name $(PROJECT_NAME) --env-file $(ENV)
COMPOSE_UP=$(COMPOSE) up
COMPOSE_DOWN=$(COMPOSE) down
COMPOSE_REBUILD=$(COMPOSE) up --build --force-recreate

# Container Commands
EXEC_ARGS=--rm --remove-orphans
EXEC_SSH=$(COMPOSE) run $(EXEC_ARGS) php /bin/bash
EXEC_CRAFT=$(COMPOSE) run $(EXEC_ARGS) php /app/craft
EXEC_NPM=$(COMPOSE) run $(EXEC_ARGS) frontend npm
EXEC_COMPOSER=$(COMPOSE) run $(EXEC_ARGS) composer --optimize-autoloader


# Actions
#--------------------------------------------------------------
.PHONY: assets backup composer craft debug dev down \
		npm nuke rebuild ssh update wipe
#--------------------------------------------------------------
assets: craft-index-assets
backup: craft-export
composer:
	@$(EXEC_COMPOSER) $(filter-out $@,$(MAKECMDGOALS)) ;
craft:
	@$(EXEC_CRAFT) $(filter-out $@,$(MAKECMDGOALS)) ;
debug:
	@$(COMPOSE) --profile debug up ;
dev: set-appid
	@$(ENV_COPY)
	@$(SEED_UNZIP)
	@$(COMPOSE_UP) ;
down:
	@$(COMPOSE_DOWN) ;
npm:
	@$(EXEC_NPM) $(filter-out $@,$(MAKECMDGOALS)) ;
nuke: composer-wipe npm-wipe
	@$(COMPOSE_DOWN) -v ;
rebuild: set-appid
	@$(ENV_COPY)
	@$(SEED_UNZIP)
	@$(COMPOSE_REBUILD) ;
restart: down rebuild
ssh:
	@$(EXEC_SSH) ;
update: composer-bump restart
wipe: composer-wipe npm-wipe restart

set-appid:
	@if ! grep -q '^$(ENV_ID)=' $(ENV) || grep -q '^$(ENV_ID)=$$' $(ENV); then \
		echo '$(ENV_ID)=Burton-$(RAND_16)' >> $(ENV); \
	fi

#--------------------------------------------------------------
# Composer Shortcuts
#--------------------------------------------------------------
composer-bump: composer-update
	@$(COMPOSE) run $(EXEC_ARGS) composer bump ;
composer-update:
	@$(EXEC_COMPOSER) update ;
composer-wipe:
	@rm -f $(CRAFT)/composer.lock
	@rm -rf $(CRAFT)/vendor

#--------------------------------------------------------------
# Craft Shortcuts
#--------------------------------------------------------------
craft-index-assets:
	@$(EXEC_CRAFT) index-assets/all ;
craft-export:
	$(EXEC_CRAFT) db/backup ;
craft-fresh-database:
	@$(EXEC_CRAFT) db/drop-all-tables --interactive=0;
	@$(EXEC_CRAFT) install/craft \
		--email='craft@example.com' \
		--password='letmein' \
		--site-name='Website' \
		--language='en-CA' \
		--site-url='$(PROJECT_URL)' \
		--interactive=0 ;
craft-reseed: craft-export
	@rm -f $(SEED_GZIP)
	@cp -p "`ls -dtr1 $(STORAGE)/backups/* | tail -1`" $(DOCKER)/seed.sql
	@gzip -c $(DOCKER)/seed.sql > $(SEED_GZIP)


# Object Storage Shortcuts
#--------------------------------------------------------------
minio-setup:
	@$(COMPOSE_UP) minio -d
	@sleep 3
	@mc mb localhost/${S3_BUCKET}
	@mc anonymous set download localhost/${S3_BUCKET}/public
	@$(COMPOSE_DOWN) minio

minio-staging-to-dev:
	@$(COMPOSE_UP) minio -d
	@sleep 3
	@mc mirror --overwrite staging/${STAGING_BUCKET}/public/content/staging localhost/${S3_BUCKET}/public/content/dev
	@mc mirror --overwrite staging/${STAGING_BUCKET}/public/design localhost/${S3_BUCKET}/public/design
	@mc mirror --overwrite staging/${STAGING_BUCKET}/private localhost/${S3_BUCKET}/private
	@$(COMPOSE_DOWN) minio

minio-dev-to-staging:
	@$(COMPOSE_UP) minio -d
	@sleep 3
	@mc mirror --overwrite localhost/${S3_BUCKET}/public/content/dev staging/${STAGING_BUCKET}/public/content/staging
	@mc mirror --overwrite localhost/${S3_BUCKET}/public/design staging/${STAGING_BUCKET}/public/design
	@mc mirror --overwrite localhost/${S3_BUCKET}/private staging/${STAGING_BUCKET}/private
	@$(COMPOSE_DOWN) minio


# NPM Shortcuts
#--------------------------------------------------------------
npm-wipe:
	@rm -f $(FRONTEND)/package-lock.json
	@rm -rf $(FRONTEND)/node_modules


# Read missing variables from .env file
#--------------------------------------------------------------
ifneq (,$(wildcard $(ENV)))
    include $(ENV)
    export $(shell sed 's/=.*//' $(ENV))
endif
#--------------------------------------------------------------

# Allow argument to be passed into the Makefile from the CLI
# ➜ https://stackoverflow.com/questions/6273608/
#--------------------------------------------------------------
ARGS=$(filter-out $@,$(MAKECMDGOALS))
%:
	@:
#--------------------------------------------------------------