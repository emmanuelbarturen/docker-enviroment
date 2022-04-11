FROM php-worker:latest
USER root
# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove Cache
RUN rm -rf /var/cache/apk/*
COPY bash_aliases /root/.bashrc

RUN chmod -R 777 .
RUN chown -R ${PHPUSER}:${PHPUSER} .
