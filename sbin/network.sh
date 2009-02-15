#! /bin/sh

WIRLESS=wlan0
WIRE=eth0

if [ -z "`ifconfig | grep $WIRLESS`" ]; then
  IP=`ifconfig $WIRE  | awk '/inet / {print $2}' | sed -e 's/addr:/IP: /'`
  echo "$WIRE $IP"
else
  ESSID=`iwconfig $WIRLESS  | grep ESSID | sed 's/.*ESSID:\"\(.*\)\".*/\1/'`
  QUALITY=`iwconfig $WIRLESS  | awk '/Link Quality=/ {print $2}' | sed -e 's/Quality.\([[:digit:]]*\).*/\1/'`
  echo "$WIRLESS $ESSID $QUALITY"
fi


