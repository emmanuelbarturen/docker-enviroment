FROM php:8.1-rc-fpm-alpine3.15

ENV PHPGROUP=laravel
ENV PHPUSER=laravel

RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}

RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

RUN apk add --no-cache pcre-dev $PHPIZE_DEPS  \
        && pecl install redis \
        && docker-php-ext-enable redis.so
RUN docker-php-ext-install -j8 pdo pdo_mysql

# Remove Cache
RUN rm -rf /var/cache/apk/*

USER ${PHPUSER}

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
