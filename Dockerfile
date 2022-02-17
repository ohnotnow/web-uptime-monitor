### PHP version we are targetting
ARG PHP_VERSION=7.4


### Placeholder for basic dev stage for use with docker-compose
FROM uogsoe/soe-php-apache:${PHP_VERSION} as dev

RUN apt-get -y update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl
COPY docker/app-start docker/app-healthcheck /usr/local/bin/
RUN chmod u+x /usr/local/bin/app-start /usr/local/bin/app-healthcheck
CMD ["tini", "--", "/usr/local/bin/app-start"]


### Prod php dependencies
FROM dev as prod-composer
ENV APP_ENV=production
ENV APP_DEBUG=0

WORKDIR /var/www/html

USER nobody

#- make paths that the laravel composer.json expects to exist
RUN mkdir -p database
#- copy the seeds and factories so that composer generates autoload entries for them
COPY database/seeders database/seeders
COPY database/factories database/factories


COPY composer.* ./

RUN composer install \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --no-dev \
    --prefer-dist

### And build the prod app
FROM dev as prod

WORKDIR /var/www/html

ENV APP_ENV=local
ENV APP_DEBUG=1

#- Copy our start scripts and php/ldap configs in
COPY docker/ldap.conf /etc/ldap/ldap.conf
COPY docker/custom_php.ini /usr/local/etc/php/conf.d/custom_php.ini

#- Copy in our prod php dep's
COPY --from=prod-composer /var/www/html/vendor /var/www/html/vendor

#- Copy in our code
COPY . /var/www/html

#- Clear any cached composer stuff
RUN rm -fr /var/www/html/bootstrap/cache/*.php

#- Make sure file permissions are ok
RUN chown -R www-data:www-data storage bootstrap/cache

#- Install any custom SSL certs
RUN docker/install_certs.sh
