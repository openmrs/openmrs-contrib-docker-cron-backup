#!/bin/sh
set -e

{ echo ""; } | crontab -

if [ -z "$SCHEDULE" ] 
then
echo "SCHEDULE environment not defined! Using 0 0 * * *"
SCHEDULE="0 0 * * *"
fi

if [ ! -z "$DIRS" ] 
then
  for DIR in ${DIRS//,/ } 
    do
      DIR_PAIR=(${DIR//:/ }) 
      COMMAND='tar -czvf /backup/'${DIR_PAIR[1]}'-`date +\%Y-\%m-\%d_\%H-\%M-\%S`.tar.gz '${DIR_PAIR[0]}
      crontab -l | { cat; echo "$SCHEDULE $COMMAND"; } | crontab -
  done
else
  echo "DIRS environment not defined!"
fi

crond -s /var/spool/cron/crontabs -f -L /var/log/cron/cron.log "$@"