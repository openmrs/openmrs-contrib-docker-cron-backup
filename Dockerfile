FROM alpine:3.6

RUN apk add --update bash

RUN apk update && apk add dcron wget rsync ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d

RUN mkdir /code
ADD cron-backup.sh /code/
ADD restore.sh /code/

WORKDIR /code

CMD ["/bin/bash" , "cron-backup.sh"]
