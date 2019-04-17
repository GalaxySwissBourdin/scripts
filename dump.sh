#!/bin/bash

################################################################
##
##   Script de sauvegarde MySQL Database Backup Script
##   Propriete de GSB
##
################################################################

export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%Y-%B-%d"`

################################################################

BACKUP_PATH='/root/backups'
BACKUP_RETAIN_DAYS=30

#################################################################

mkdir -p ${BACKUP_PATH}/${TODAY}

for i in $*
do
	echo -e "sauvegarde de la base ${i}"
	
	mysqldump --verbose ${i} -u backup > ${BACKUP_PATH}/${TODAY}/${i}-${TODAY}.sql
	if test $? -eq 0
	then
 		echo "Sauvegarde OK"
	else
		echo "Erreur pendant la sauvegarde"
	fi
	
	gzip -rv9 ${BACKUP_PATH}/${TODAY}/${i}-${TODAY}.sql
	if test $? -eq 0
	then
 		echo "Compression OK"
	else
		echo "Erreur pendant la compression"
	fi
done

##### Purge des sauvegardes de plus de {BACKUP_RETAIN_DAYS} jours  #####

DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`

if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi
