#!/bin/bash

export PATH=/bin:/usr/bin:/usr/local/bin

################################################################

BACKUP_PATH='/root/backups/'
TODAY=`date +"%Y-%B-%d"`

# echo "Entrer le nom de la base a restaurer"
# read $BASE
# sleep 1
#
# echo "Entrer le chemin du fichier .sql.gz"
# read $BASE
# sleep 1

# Recuperation du nom de fichier de la sauvegarde la plus récente
# ls -ltrR $TODAY | grep $BASE > $FILE
# LAST_SQL_BACKUP=$(ls $BASE*.sql.gz | tail -n 1)

if test $# -lt 2
then
  echo "Entrez le chemin de la base et le nom de la base"
  echo "Exemple :"
  echo "./restore.sh 2019-avril-23/glpi-2019-avril-23-12.sql.gz glpi"
  exit 99
fi

FILE="$BACKUP_PATH$1"

# Import du fichier base.sql.gz dans mysql
gunzip < $1 | mysql -u backup $2 --verbose

if test $? -eq 0
then
  echo "Restauration OK"
else
  echo "Erreur pendant la restauration"
fi
