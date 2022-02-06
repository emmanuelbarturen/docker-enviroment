FROM php:7.3-fpm-alpine

ADD crontab.sh /etc/crontab.sh
ARG ENABLE_CRONTAB
ENV ENABLE_CRONTAB ${ENABLE_CRONTAB}
ENTRYPOINT ["sh", "/etc/crontab.sh"]
CMD ["crond", "-f"]