#!/bin/bash
#daily backup script by rmsy

#-----CHANGE THESE SETTINGS-----
BACKUPSQL="YES" #use this to enable/disable SQL backups
KEEPOLDSQL="NO" #do you want to keep old SQL backups (otherwise only one will be kept) enter "YES" to keep them
SQLDATABASE="" #SQL database name
SQLDATABASEPW="" #SQL database password
SQLDATABASEUSER="" #SQL database username
SQLDATABASEHOST="localhost" #SQL database hostname

MINECRAFTBACKUPDIR="" #full filepath to your Minecraft backup directory, WITHOUT a trailing backslash
SQLBACKUPDIR="" #full filepath to your SQL backup directory, WITHOUT a trailing backslash

MINECRATTIMESTAMPFORMAT="%m-%d-%y" #the GNU 'date' arguments for the timestamp that will go into your daily Minecraft backup's file name. don't include any spaces or backslashes or other weird characters. if you don't know how to use this, the current setting is fine. it will produce a file named "[Filename]04-19-12.tar"
MINECRAFTBACKUPFILENAME="Minecraft-" #the prefix to the timestamp in the daily Minecraft backup's file name. for example, this would produce a file named "Minecraft-[Timestamp]"

SQLTIMESTAMPFORMAT="%m-%d-%y" #the GNU 'date' arguments for the timestamp that will go into your daily SQL backup's file name. don't include any spaces or backslashes or other weird characters. if you don't know how to use this, the current setting is fine. it will produce a file named "[Filename]04-19-12.tar"
SQLBACKUPFILENAME="SQL-" #the prefix to the timestamp in the daily SQL backup's file name. for example, this would produce a file named "SQL-[Timestamp]"

#holy long variable names batman
#-----DON'T EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING-----

#-----COMPRESS THE DAY'S MINECRAFT BACKUPS-----
MINECRAFTTIMESTAMP=$(date +"${MINECRAFTTIMESTAMPFORMAT}")
tar -uvvf ${MINECRAFTBACKUPDIR}/${MINECRAFTBACKUPFILENAME}${MINECRAFTTIMESTAMP}.tar ${MINECRAFTBACKUPDIR}/*:*.tar
rm -rf ${MINECRAFTBACKUPDIR}/*:*.tar
    DATE=$(date)
    echo "Successfully compressed Minecraft backups at ${MINECRAFTBACKUPDIR}/${MINECRAFTBACKUPFILENAME}${MINECRAFTTIMESTAMP}.tar on ${DATE}"

#-----BACK UP SQL-----
if [ "$BACKUPSQL" = "YES" ]; then
    if [ "$KEEPOLDSQL" != "YES" ]; then
        rm -rf ${SQLBACKUPDIR}/*
    fi
    mysqldump -u ${SQLDATABASEUSER} -h ${SQLDATABASEHOST} --password=${MYSQLDATABASEPW} ${MYSQLDATABASE} > ${SQLBACKUPDIR}/temp.sql
    SQLTIMESTAMP=$(date +"${SQLTIMESTAMPFORMAT}")
    tar -uvvf ${SQLBACKUPDIR}/${SQLBACKUPFILENAME}${SQLTIMESTAMP}.tar ${SQLBACKUPDIR}/temp.sql
    rm -rf ${SQLBACKUPDIR}/temp.sql
    DATE=$(date)
    echo "Successfully backed up MySQL database at ${SQLBACKUPDIR}/${SQLBACKUPFILENAME}${SQLTIMESTAMP}.tar on ${DATE}"
fi