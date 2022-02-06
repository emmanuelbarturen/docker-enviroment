FROM php:7.3-fpm-alpine

ENV PHPGROUP=laravel
ENV PHPUSER=laravel

RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}

RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Remove Cache
RUN rm -rf /var/cache/apk/*

## activate CRONTAB if enabled
ADD crontab.sh /etc/crontab.sh
ARG ENABLE_CRONTAB
ENV ENABLE_CRONTAB ${ENABLE_CRONTAB}
ENTRYPOINT ["sh", "/etc/crontab.sh"]
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
