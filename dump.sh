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

# Execution pour chaque nom de base passé en argument
for i in $*
do
	# Annonce de la base sauvegardée
	echo -e "sauvegarde de la base ${i}"

	# Export de la base vers un dossier avec la date
	# Le nom du fichier créé porte le nom de la base et la date
	mysqldump --verbose ${i} -u backup > ${BACKUP_PATH}/${TODAY}/${i}-${TODAY}.sql

	# Vérification que l'export s'est déroulé correctement
	if test $? -eq 0
	then
 		echo "Sauvegarde OK"
	else
		echo "Erreur pendant la sauvegarde"
	fi

	# Compression des fichiers créés avec le meilleur taux de compression
	gzip -rv9 ${BACKUP_PATH}/${TODAY}/${i}-${TODAY}.sql

	# Vérification que la compression s'est déroulée correctement
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
