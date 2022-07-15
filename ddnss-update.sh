#!/bin/sh

KEYAUTH=$DDNSS_KEYAUTH
HOSTNAME=$DDNSS_HOSTNAME
CONFIG="/config"
ALLHOST="all"

DATE=`date +%Y-%m-%d\ %H:%M:%S`
IP=`wget -q -O - https://www.ddnss.de/meineip.php| grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
UPDIP=`cat $CONFIG/updip.txt`
echo "Current IP=$UPDIP" >> $CONFIG/log.txt

if [ "$IP" == "$UPDIP" ]; then
    echo "$DATE - IP is unchanged - NO UPDATE" >> $CONFIG/log.txt
else
    echo "$DATE - New-IP: $ip / Old-IP: $UPDIP - UPDATE!" >> $CONFIG/log.txt
    echo $IP > $CONFIG/updip.txt
    wget -q -O - 'https://www.ddnss.de/upd.php?key='$KEYAUTH'&host='$HOSTNAME'&host='$ALLHOST''
    echo " "
    echo "Update of IP address performed." >> $CONFIG/log.txt
fi
