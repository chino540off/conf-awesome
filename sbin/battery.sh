#!/bin/bash

### BATTERY
REM=`awk '/remaining capacity/ { print $3 }' /proc/acpi/battery/BAT0/state`
AC=`awk '/charging state/ { print $3 }' /proc/acpi/battery/BAT0/state`
LAST=`awk '/last full/ { print $4}' /proc/acpi/battery/BAT0/info`

#STATE=`awk '{print $2}' /proc/acpi/ac_adapter/AC0/state`
#if [ "$STATE" = "on-line" ]; then
  #BAT=$(echo $REM $LAST | awk '{printf "Bat: %.1f%%, AC", ($1/$2)*100'})
#else
  #PRESENT=`awk '/present rate/ { print $3}' /proc/acpi/battery/BAT0/state`
  #BAT=$(echo $REM $LAST $PRESENT | \
    #awk '{printf "Bat: %.1f%%", ($1/$2)*100}')
  #  awk '{printf "Bat: %.1f%%, %d min", ($1/$2)*100, ($1/$3)*60}')
#fi
if [ "$AC" = "charging" -o "$AC" = "charged" ]; then
  AC="AC"
else
  AC="BAT"
fi

PERCENT=$(echo $REM $LAST | awk '{printf "%d", ($1/$2)*100'})

echo "$PERCENT $AC"

