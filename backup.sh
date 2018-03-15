#!/bin/sh
set -e

if [ ! -z "$DIRS" ] 
then
  DATE=`date +%Y-%m-%d_%H-%M-%S`
  for DIR in ${DIRS//,/ } 
    do
      DIR_PAIR=(${DIR//:/ })
      tar -czvf /backup/${DIR_PAIR[1]}-$DATE.tar.gz ${DIR_PAIR[0]}
  done
else
  echo "DIRS environment not defined!"
fi