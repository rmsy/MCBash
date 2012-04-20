#!/bin/bash
#[anything more frequent than dai]ly backup script by rmsy

#-----CHANGE THESE SETTINGS-----
MINECRAFTBACKUPDIR="" #full filepath to your Minecraft backup directory, WITHOUT a trailing backslash
MINECRAFTSERVERDIR="" #full filepath to your Minecraft server directory, WITHOUT a trailing backslash

#-----DO NOT CHANGE ANYTHING BELOW THIS LINE OR YOUR DAILY COMPRESSION SCRIPT WILL NOT WORK-----

DATE=$(date +"%T")
tar -uvvf ${MINECRAFTBACKUPDIR}/${DATE}.tar ${MINECRAFTSERVERDIR}
rm -rf ${MINECRAFTSERVERDIR}/server.log*
DATE=$(date)
echo "Successfully backed up Minecraft server at ${MINECRAFTBACKUPDIR}/${DATE}.tar and your server.log cleared on ${DATE}"