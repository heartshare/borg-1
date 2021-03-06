#!/bin/bash

###
#	RCLONE for BACKUPS REPLICATION
#
##	HOW TO USE
#	bash /full/path/rclone-sync.sh
#
##	CONSIDERATIONS
#	tbd
###

echo "===================================================="
#	checking for other intences
process=`ps aux | grep "rclone-sync.sh" | grep -v grep | wc -l`
#process=$?
echo "Qty process: " $process

if [ $process -gt 0 ]; then
		echo $(date +"%Y%m%d %H:%M:%S")" ERROR: another instance already running"
		exit 1
	else
		echo $(date +"%Y%m%d %H:%M:%S")" INFO: no other instance is running"
fi

####	DMESG
#	LOCAL to ONEDRIVE-YAHOO	
echo $(date +"%Y%m%d %H:%M:%S")" SYNC: local DMESG to onedrive-yahoo:/dmesg/comp"
rclone sync /mnt/nostromo-repository/dmesg/comp/ onedrive-yahoo:/dmesg/comp
	if $? != 0; then
		echo $(date +"%Y%m%d %H:%M:%S")" ERROR during rclone sync /mnt/nostromo-repository/dmesg/comp/ onedrive-yahoo:/dmesg/comp"
		bash /home/jfc/scripts/telegram-message.sh "Borg rclone sync" "ERROR during" "rclone sync /mnt/nostromo-repository/dmesg/comp/ onedrive-yahoo:/dmesg/comp" > /dev/null
		exit 1
	fi

####	BACKUPS
#	LOCAL to ONEDRIVE-YAHOO	
echo $(date +"%Y%m%d %H:%M:%S")" SYNC: local to onedrive-yahoo:borg/"
rclone sync /mnt/iscsi-borg/ onedrive-yahoo:borg/
	if $? != 0; then
		echo $(date +"%Y%m%d %H:%M:%S")" ERROR during rclone sync /mnt/iscsi-borg/ onedrive-yahoo:borg/"
		bash /home/jfc/scripts/telegram-message.sh "Borg rclone sync" "ERROR during" "rclone sync /mnt/iscsi-borg/ onedrive-yahoo:borg/" > /dev/null
		exit 1
	fi

#	ONEDRIVE-YAHOO to CONCARI_C
echo $(date +"%Y%m%d %H:%M:%S")" SYNC: onedrive-yahoo:borg/ to gdrive-concari_c:"
rclone sync onedrive-yahoo:borg/ gdrive-concari_c:
	if $? != 0; then
		echo $(date +"%Y%m%d %H:%M:%S")" ERROR during rclone sync onedrive-yahoo:borg/ gdrive-concari_c:"
		bash /home/jfc/scripts/telegram-message.sh "Borg rclone sync" "ERROR during" "rclone sync onedrive-yahoo:borg/ gdrive-concari_c:" > /dev/null
		exit 1
	fi

#	CONCARI_C to SANTI
echo $(date +"%Y%m%d %H:%M:%S")" SYNC: gdrive-concari:backups_c to gdrive-santi:backups_c"
rclone sync gdrive-concari:backups_c gdrive-santi:backups_c
	if $? != 0; then
		echo $(date +"%Y%m%d %H:%M:%S")" ERROR during rclone sync gdrive-concari:backups_c gdrive-santi:backups_c"
		bash /home/jfc/scripts/telegram-message.sh "Borg rclone sync" "ERROR during" "rclone sync gdrive-concari:backups_c gdrive-santi:backups_c" > /dev/null
		exit 1
	fi

#	CONCARI_C to COCHISE
echo $(date +"%Y%m%d %H:%M:%S")" SYNC: gdrive-concari:backups_c to gdrive-cochise:backups_c"
rclone sync gdrive-concari:backups_c gdrive-cochise:backups_c
	if $? != 0; then
		echo $(date +"%Y%m%d %H:%M:%S")" ERROR during rclone sync gdrive-concari:backups_c gdrive-cochise:backups_c"
		bash /home/jfc/scripts/telegram-message.sh "Borg rclone sync" "ERROR during" "rclone sync gdrive-concari:backups_c gdrive-cochise:backups_c" > /dev/null
		exit 1
	fi

#	CONCARI_C to COCHISE_UNKNOW
echo $(date +"%Y%m%d %H:%M:%S")" SYNC: gdrive-concari:backups_c to gdrive-cochise-unknow:backups_c"
rclone sync gdrive-concari:backups_c gdrive-cochise-unknow:backups_c
	if $? != 0; then
		echo $(date +"%Y%m%d %H:%M:%S")" ERROR during rclone sync gdrive-concari:backups_c gdrive-cochise-unknow:backups_c"
		bash /home/jfc/scripts/telegram-message.sh "Borg rclone sync" "ERROR during" "rclone sync gdrive-concari:backups_c gdrive-cochise-unknow:backups_c" > /dev/null
		exit 1
	fi

exit 0
