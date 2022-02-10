FROM php:7.3-fpm-alpine

ENV PHPGROUP=laravel
ENV PHPUSER=laravel

RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}

RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN apk add --no-cache pcre-dev $PHPIZE_DEPS bash \
        && pecl install redis \
        && docker-php-ext-enable redis.so
RUN docker-php-ext-install pdo pdo_mysql

# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove Cache
RUN rm -rf /var/cache/apk/*

COPY bash_aliases /root/.bashrc

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
