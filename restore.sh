#!/bin/sh
set -e

if [ ! -z "$DIRS" ] 
then
  for DIR in ${DIRS//,/ } 
    do
      DIR_PAIR=(${DIR//:/ }) 
      tar -zxvf /backup/${DIR_PAIR[1]}-$1.tar.gz -C /
  done
else
  echo "DIRS environment not defined!"
fi
