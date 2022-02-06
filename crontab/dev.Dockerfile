ARG APP_NAME
FROM ${APP_NAME}_workspace

ADD crontab.sh /etc/crontab.sh
ARG ENABLE_CRONTAB
ENV ENABLE_CRONTAB ${ENABLE_CRONTAB}
ENTRYPOINT ["sh", "/etc/crontab.sh"]
CMD ["crond", "-f"]