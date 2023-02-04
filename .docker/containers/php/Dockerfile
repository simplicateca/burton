# original source
# ------------------------------------------------------------------------------------------------
# https://github.com/simplicate-web/docker-images/blob/master/php/php-8.1-alpine/Dockerfile

FROM simplicateweb/php-8.1-alpine:latest

WORKDIR /var/www/project

COPY ./composer_install.sh .
RUN chmod a+x composer_install.sh

COPY ./run_queue.sh .
RUN chmod a+x run_queue.sh \
    && \
    mkdir -p /var/www/project/cms/storage \
    && \
    mkdir -p /var/www/project/cms/web/cpresources \
    && \
    chown -R www-data:www-data /var/www/project

WORKDIR /var/www/project/cms

# Run the composer_install.sh script that will do a `composer install`:
# - If `composer.lock` is missing
# - If `vendor/` is missing
# ...then start up php-fpm. The `run_queue.sh` script in the queue container
# will take care of running any pending migrations and apply any Project Config changes,
# as well as set permissions via an async CLI process
CMD /bin/sh /var/www/project/composer_install.sh \
    && \
    php-fpm