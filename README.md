# borg backup scripts
Bash Scripts for Borg Backup

# How to Use
sh borg-b.sh DOCKER /mnt/iscsi-borg/nostromo-docker /mnt/nostromo-docker 7 4 3

# Parameters
1 $TITLE - Titulo del Backup	DOCKER 

2 $REP - Repositorio, ejemplo 	/mnt/iscsi-borg/nostromo-docker

3 $ORI - Origen, ejemplo	/mnt/nostromo-docker

4 $D - Prune Days	7

5 $W - Prune Weeks	4

6 $M - Prune Months	6

warning! it uses the telegram-message.sh script, feel free to remove/modify it, or
Get it from https://github.com/MrCaringi/notifications
