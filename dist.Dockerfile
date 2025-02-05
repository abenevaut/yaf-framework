# This is a sample Dockerfile for a YAF production application
#
# docker build . --tag abenevaut/vapor-nginx:test
# docker run -p 8080:8080 abenevaut/vapor-nginx:test
#

FROM ghcr.io/abenevaut/vapor-nginx:php83

LABEL maintainer="<Your name & email>"

RUN pecl channel-update pecl.php.net \
    && pecl install yaf \
    && rm -rf /tmp/pear

RUN docker-php-ext-enable yaf

COPY --chown=nobody rootfs/ /
COPY rootfs/usr/local/etc/php/conf.d/docker-php-ext-yaf.ini.production /usr/local/etc/php/conf.d/docker-php-ext-yaf.ini

COPY . /var/task

# Todo: composer install, be sure app.ini exists
