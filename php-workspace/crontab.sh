#!/bin/sh
set -e

# Enable Laravel schedule
if [[ "${ENABLE_CRONTAB:-1}" = "1" ]]; then
  cat /dev/null >/etc/crontabs/root
  echo "* * * * * cd /var/www/html && php artisan schedule:run >> /dev/null 2>&1" >> /etc/crontabs/root
  crond -f
fi

exec "$@"