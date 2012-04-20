#!/bin/bash
#bootup and continuation script by rmsy

#NOTE: THIS IS NOT A START SCRIPT. THIS IS SIMPLY A SCRIPT TO MAKE SURE THAT YOUR START SCRIPT IS ALWAYS RUNNING (yo dawg). THIS DOES NOT START YOUR MINECRAFT SERVER, BUT RATHER YOUR START SCRIPT.

#-----CHANGE THESE SETTINGS-----
STARTSCRIPTPATH="" #the full filepath to your start script

#-----DO NOT CHANGE ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING-----
ISRUNNING=$(screen -ls | grep bukkit)
if [ -z "$ISRUNNING" ]; then
    screen -S bukkit -dmS sh ${STARTSCRIPTPATH}
    echo "Start script was not running. Started."
else
    echo "Start script was already running!"
fi