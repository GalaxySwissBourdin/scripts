#!/bin/bash

################################################################
##
##   Script de sauvegarde MySQL Database Backup Script
##   Propriete de GSB
##
################################################################

export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`

################################################################
################## Update below values  ########################

BACKUP_PATH='/root/backups'
DATABASE_NAME='glpi'
BACKUP_RETAIN_DAYS=30   ## Number of days to keep local backup copy

#################################################################

mkdir -p ${BACKUP_PATH}/${TODAY}
echo "Backup started for database - ${DATABASE_NAME}"

for i in $*
do
	echo -e "sauvegarde de la base ${i}"
	mysqldump --verbose ${i} | gzip > ${BACKUP_PATH}/${TODAY}/${i}-${TODAY}.sql.gz
done

if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
fi


##### Remove backups older than {BACKUP_RETAIN_DAYS} days  #####

DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`

if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi

### End of script ####
