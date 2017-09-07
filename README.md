CRON docker image available as openmrs/cron-docker:1.0.0

It tars directories DIR1, DIR2, etc. defined in the DIRS environment variable in the format DIR1:NAME1,DIR2:NAME2,... under /backup/NAME1-Y-m-d_H-M-S.tar.gz by defined SCHEDULE.

Example of use with docker-compose:

  backup:
    image: openmrs/cron-backup:1.0.0
    depends_on:
      - api
    volumes:
      - mongo_data:/mongo_data
      - solr_data:/solr_data
      - ${BACKUP_DIR-./backups}:/backup
    environment:
      - DIRS=/mongo_data:mongo,/solr_data:solr
      - SCHEDULE=0 0 * * *
    restart: always
    healthcheck:
      test: "exit 0"