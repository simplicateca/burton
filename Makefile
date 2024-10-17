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
ENV_TEST=$(shell [ -f $(ENV_EMPTY)  ] && cp -n $(ENV_EMPTY) $(ENV) || true)

# Utilities
RAND_16=$(shell head /dev/urandom | tr -dc a-z0-9 | head -c 16)

# Database Seed
SEED_PATH=$(DOCKER)/seed
SEED_GZIP=$(DOCKER)/seed.sql.gz
SEED_UNZIP=mkdir $(SEED_PATH) && gzip -dkc $(SEED_GZIP) > $(SEED_PATH)/craft.sql
SEED_NAME=$(DOCKER)/Craft-$(date %Y-%m-%d-%H%M).sql
SEED_TEST=$(shell [ -f $(SEED_GZIP) ] && [ ! -d $(SEED_PATH) ] && $(SEED_UNZIP) || true)

# Project
PROJECT_ID=Burton-$(RAND_16)
PROJECT_ID_TEST=$(shell grep -q '^$(ENV_ID)=' $(ENV) && [ -z "$(grep '^$(ENV_ID)=' $(ENV) | cut -d '=' -f 2)" ] && sed -i 's/^$(ENV_ID)=/$(ENV_ID)=$(PROJECT_ID)/' $(ENV))
PROJECT_ID=$(shell grep -E '^$(ENV_ID)=' $(ENV) | cut -d '=' -f 2)
PROJECT_DIR=$(shell basename $(realpath $(dir $(CURDIR))/..))
PROJECT_NAME=$(if $(PROJECT_ID),$(PROJECT_ID),$(PROJECT_DIR))
PROJECT_URL=$(shell grep -E '^CRAFT_WEB_URL=' $(ENV) | cut -d '=' -f 2)


# Docker Compose
COMPOSE=docker compose --project-name $(PROJECT_NAME) --env-file $(ENV)
COMPOSE_UP=$(COMPOSE) up
COMPOSE_DOWN=$(COMPOSE) down
COMPOSE_REBUILD=$(COMPOSE) up --build --force-recreate

# Container Commands
EXEC_SSH=$(COMPOSE) exec php /bin/bash
EXEC_CRAFT=$(COMPOSE) exec php /app/craft
EXEC_NPM=$(COMPOSE) exec frontend npm
EXEC_COMPOSER=$(COMPOSE) run composer --rm --optimize-autoloader


# Actions
#--------------------------------------------------------------
.PHONY: assets backup composer craft debug dev down \
		npm nuke rebuild reinstall reseed ssh update wipe
#--------------------------------------------------------------
assets: craft-index-assets
backup: craft-export
composer:
	@$(EXEC_COMPOSER) $(filter-out $@,$(MAKECMDGOALS)) ;
craft:
	@$(EXEC_CRAFT) $(filter-out $@,$(MAKECMDGOALS)) ;
debug:
	@$(COMPOSE) --profile debug up ;
dev:
	@$(COMPOSE_UP) ;
down:
	@$(COMPOSE_DOWN) ;
npm:
	@$(EXEC_NPM) $(filter-out $@,$(MAKECMDGOALS)) ;
nuke: composer-wipe npm-wipe
	@$(COMPOSE_DOWN) -v ;
rebuild:
	@$(COMPOSE_REBUILD) ;
restart: down rebuild
reinstall: craft-empty-db restart
reseed: craft-reseed
ssh:
	@$(EXEC_SSH) ;
update: composer-bump restart
wipe: composer-wipe npm-wipe restart

#--------------------------------------------------------------
# Composer Shortcuts
#--------------------------------------------------------------
composer-bump: composer-update
	@$(EXEC_COMPOSER) bump ;
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
	@$(EXEC_CRAFT) db/backup ;
craft-empty-db:
	@$(EXEC_CRAFT) db/drop-all-tables ;
	@$(EXEC_CRAFT) install \
		--email='craft@example.com' \
		--password='letmein' \
		--site-name='Craft CMS' \
		--site-url='$(PROJECT_URL)' ;
craft-reseed:
	@rm -f $(SEED_GZIP)
	@cp -p "`ls -dtr1 $(STORAGE)/backups/* | tail -1`" $(SEED_NAME)
	@gzip -c $(SEED_NAME) > $(SEED_PATH)


# NPM Shortcuts
#--------------------------------------------------------------
npm-wipe:
	@rm -f $(FRONTEND)/package-lock.json
	@rm -rf $(FRONTEND)/node_modules

%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
