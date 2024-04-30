.PHONY: dev run down prep craft composer npm lint build exportdb exportdbseed ssh clean wipedb nuke

SEED_DIR  :=./etc/database-seed
SQL_FILES :=$(SEED_DIR)/*.sql
GZ_FILES  :=$(SEED_DIR)/*.sql.gz
CRAFT_PATH:=/app/craft
IS_RUNNING:=`docker compose ps --services | grep 'php'`

# > make dev
# > make run (runs in the background)
# ---------------------------------------------------------------------
# launches and prepares the docker based development environment
dev: prep
	[ $(IS_RUNNING) ] || docker compose up ;

run: prep
	[ $(IS_RUNNING) ] || docker compose up -d ;

down:
	docker compose down ;


# > make prep
# ---------------------------------------------------------------------
# takes care of some housekeeping before launching docker
prep:
	[ $(IS_RUNNING) ] || ( [ "ls $(GZ_FILES) &>/dev/null" ] && gunzip -kqf $(GZ_FILES) )
	[ $(IS_RUNNING) ] || cp -n craftcms/.env.example craftcms/.env


# > make craft "tool/command arg1 arg2"
# ---------------------------------------------------------------------
# issue commands to the craft cli console
craft:
	docker compose exec php $(CRAFT_PATH) $(filter-out $@,$(MAKECMDGOALS)) ;


# > make composer "install php/library"
# ---------------------------------------------------------------------
# issue commands to the php composer cli. surround arguments in quotes
composer:
	docker compose run composer $(filter-out $@,$(MAKECMDGOALS)) ;


# > make npm "install javascript/package"
# ---------------------------------------------------------------------
# issue commands to the npm cli. surround arguments in quotes
npm:
	docker compose exec frontend npm $(filter-out $@,$(MAKECMDGOALS)) ;


# > make lint
# ---------------------------------------------------------------------
# run the vite/npm lint scripts
lint:
	docker compose exec frontend npm run lint ;


# > make build
# ---------------------------------------------------------------------
# run the vite/npm lint & build scripts
build:
	docker compose exec frontend npm run build ;


# > make exportdb
# ---------------------------------------------------------------------
# short cut to run the craft database export
exportdb:
	docker compose exec php $(CRAFT_PATH) db/backup ;


# > make exportdbseed
# ---------------------------------------------------------------------
# set the current database as the new seed file (./etc/database-seed)
exportdbseed: exportdb
	rm -f $(GZ_FILES)
	rm -f $(SQL_FILES)
	cp -p "`ls -dtr1 ./craftcms/storage/backups/* | tail -1`" $(SEED_DIR)
	gzip $(SQL_FILES)


# > make ssh
# ---------------------------------------------------------------------
# ssh into the php-fpm container
ssh:
	docker compose exec php /bin/bash ;


# > make clean
# ---------------------------------------------------------------------
# deletes php (./craftcms/vendor) & node (./frontend/node_modules)
# directories, along with respective lock files
clean:
	rm -f craftcms/composer.lock
	rm -rf craftcms/vendor
	rm -f frontend/package-lock.json
	rm -rf frontend/node_modules


# > make wipedb
# ---------------------------------------------------------------------
# remove the mysql database. files in './etc/database-seed' will be
# used to recreate the database the next time the project spins up
wipedb:
	docker compose down -v ;


# > make nuke
# ---------------------------------------------------------------------
# removes all persistent data (mysql volume included), deletes composer
# and php libraries, and recreates the entire project from scratch
nuke: clean wipedb
	docker compose up --build --force-recreate ;


%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line