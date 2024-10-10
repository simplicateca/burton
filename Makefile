#--------------------------------------------------------------
# Craft CMS Project
#--------------------------------------------------------------
.PHONY: dev dev-rebuild dev-ssh dev-down \
		autoconfig \
		craft craft-update craft-assetsync \
		composer composer-update \
		db-export db-reseed db-reset db-debug \
		n8n-export n8n-export-credentials n8n-import n8n-import-credentials \
		npm \
		wipe-volumes wipe-backend wipe-frontend wipe-nuke

#--------------------------------------------------------------
# Dotenv File Paths
#--------------------------------------------------------------
ENV_SMPL  :=craftcms/example.env
ENV_PATH  :=craftcms/.env

#--------------------------------------------------------------
# Database Seed & Backup Paths
#--------------------------------------------------------------
SEED_PATH :=./etc/dev.local/seed
SEED_GZIP :=./etc/dev.local/seed.sql.gz
SEED_UNZIP:=mkdir $(SEED_PATH) && gzip -dkc $(SEED_GZIP) > $(SEED_PATH)/init.sql
SEED_NAME :=$(SEED_DIR)/Craft-$(date %Y-%m-%d-%H%M).sql

#--------------------------------------------------------------
# n8n Backup Paths
#--------------------------------------------------------------
N8N_FLOWS=/home/node/n8n/workflows
N8N_CREDS=/home/node/n8n/credentials

#--------------------------------------------------------------
# Craft CMS
#--------------------------------------------------------------
CRAFT_PATH:=/app/craft

#--------------------------------------------------------------
# Docker Settings (compose.yaml)
#--------------------------------------------------------------
DOCKER_DB:=mysql
DOCKER_PHP:=php
DOCKER_ENV:=--env-file $(ENV_PATH)
DOCKER_COMPOSE:=docker compose $(DOCKER_ENV)
DOCKER_EXEC_PHP:=$(DOCKER_COMPOSE) exec php
DOCKER_EXEC_CRAFT:=$(DOCKER_COMPOSE) exec php $(CRAFT_PATH)
DOCKER_EXEC_N8N:=$(DOCKER_COMPOSE) exec --user node n8n n8n
DOCKER_PROFILE_REINSTALL:=freshdb
DOCKER_PROFILE_DEBUG:=debug

#--------------------------------------------------------------
# Autoconfig Environment
#--------------------------------------------------------------
autoconfig: auto-cd auto-db auto-env

auto-cd:
	@cd "$(pwd -P)"

auto-db:
	@[ -f $(SEED_GZIP) ] && [ ! -d $(SEED_PATH) ] && $(SEED_UNZIP) || true

auto-env:
	@[ -f $(ENV_SMPL)  ] && cp -n $(ENV_SMPL) $(ENV_PATH) || true

#--------------------------------------------------------------
# Development Environment Up/Down
#--------------------------------------------------------------
dev: autoconfig
	$(DOCKER_COMPOSE) up ;

dev-rebuild: autoconfig
	$(DOCKER_COMPOSE) --build --force-recreate up ;

dev-ssh: autoconfig
	$(DOCKER_EXEC_PHP) /bin/bash ;

dev-down: autoconfig
	$(DOCKER_COMPOSE) down ;



#--------------------------------------------------------------
# Composer - PHP Dependency Manager
#--------------------------------------------------------------
composer: autoconfig
	$(DOCKER_COMPOSE) run composer $(filter-out $@,$(MAKECMDGOALS)) ;

composer-update: autoconfig
	$(DOCKER_COMPOSE) run composer $(filter-out $@,$(MAKECMDGOALS)) ;


#--------------------------------------------------------------
# Craft - Console Commands
#--------------------------------------------------------------
craft: autoconfig
	$(DOCKER_EXEC_CRAFT) $(filter-out $@,$(MAKECMDGOALS)) ;

craft-update: autoconfig
	$(DOCKER_EXEC_CRAFT) $(filter-out $@,$(MAKECMDGOALS)) ;

craft-assetsync: autoconfig
	$(DOCKER_EXEC_CRAFT) $(filter-out $@,$(MAKECMDGOALS)) ;


#--------------------------------------------------------------
# Database Management
#--------------------------------------------------------------
db-export: autoconfig
	$(DOCKER_EXEC_CRAFT) db/backup ;

db-reseed: db-export
	rm -f $(SEED_GZIP)
	cp -p "`ls -dtr1 ./craftcms/storage/backups/* | tail -1`" etc/$(SEED_NAME)
	gzip -c etc/$(SEED_NAME) > $(SEED_PATH)

db-reset: db-export
	$(DOCKER_COMPOSE) rm -v $(DOCKER_DB) ;
	$(DOCKER_COMPOSE) --profile $(DOCKER_PROFILE_REINSTALL) up ;

db-debug: autoconfig
	$(DOCKER_COMPOSE) --profile $(DOCKER_PROFILE_DEBUG) up ;


#--------------------------------------------------------------
# Frontend NodeJS
#--------------------------------------------------------------
npm: autoconfig
	$(DOCKER_COMPOSE) exec frontend npm $(filter-out $@,$(MAKECMDGOALS)) ;



#--------------------------------------------------------------
# n8n - workflow automation json import/export
#--------------------------------------------------------------
# https://docs.n8n.io/hosting/cli-commands/#import-workflows-and-credentials
# https://docs.n8n.io/hosting/cli-commands/#export-workflows-and-credentials
n8n-import: autoconfig
	$(DOCKER_EXEC_N8N) import:workflow --separate --input=$(N8N_FLOWS) ;

n8n-import-credentials: autoconfig
	$(DOCKER_EXEC_N8N) import:credentials --separate --input=$(N8N_CREDS) ;

n8n-export: autoconfig
	$(DOCKER_EXEC_N8N) export:workflow --backup --output=$(N8N_FLOWS) ;

n8n-export-credentials: autoconfig
	$(DOCKER_EXEC_N8N) export:credentials --backup --output=$(N8N_CREDS) ;



#--------------------------------------------------------------
# Wipe persistent data from the local env
#--------------------------------------------------------------
wipe-volumes: autoconfig
	$(DOCKER_COMPOSE) down -v ;

wipe-frontend:
	rm -f frontend/package-lock.json
	rm -rf frontend/node_modules

wipe-backend:
	rm -f craftcms/composer.lock
	rm -rf craftcms/vendor

wipe-nuke: wipe-volumes wipe-backend wipe-frontend dev-rebuild



%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
