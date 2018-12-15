#!/bin/sh
set -e
backup() {
  if [ ! -z "$DIRS" ]; then
    DATE=`date +%Y-%m-%d_%H-%M-%S`
    for DIR in ${DIRS//,/ }
    do
      DIR_PAIR=(${DIR//:/ })
      tar -czvf /backup/${DIR_PAIR[1]}-$DATE.tar.gz ${DIR_PAIR[0]}
    done
  else
    echo "DIRS environment not defined!"
  fi
}

restore() {
  if [ ! -z "$DIRS" ]; then
    for DIR in ${DIRS//,/ }
    do
      DIR_PAIR=(${DIR//:/ })
      tar -zxvf /backup/${DIR_PAIR[1]}-$2.tar.gz -C /
    done
  else
    echo "DIRS environment not defined!"
  fi
}

usage() {
  echo "Usage: bash backup.sh <backup|restore> <backup timestamp in the form YYYY-MM-DD-hh:mm:ss>"
  echo "Example: bash backup.sh restore 2018-12-15_00-00-01"
}

OPERATION=$1
case "$OPERATION" in
  "backup" )
    backup
    ;;
  "restore" )
    restore $*
    ;;
  * )
    usage
    ;;
esac
