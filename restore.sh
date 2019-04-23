#!/bin/bash

export PATH=/bin:/usr/bin:/usr/local/bin

################################################################

BACKUP_PATH='/root/backups'
TODAY=`date +"%Y-%B-%d"`


echo "Entrer nom de la base a restaurer"
read $BASE
sleep 1


# Recuperation du nom de fichier de la sauvegarde la plus récente
#ls -ltrR $TODAY | grep $BASE > $FILE
LAST_SQL_BACKUP=$(ls $BASE*.sql.gz | tail -n 1)



# Import du fichier base.sql.gz dans mysql
gunzip < $LAST_SQL_BACKUP | mysql -u backup $BASE
