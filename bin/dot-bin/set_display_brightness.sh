#!/usr/bin/bash

NOTIFY_ID=89715623

display=$1
brightness=$2

if (($(echo "$brightness < 0" | bc -l))); then
  brightness=0
elif (($(echo "$brightness > 1" | bc -l))); then
  brightness=1
fi

brightness_percent=$(printf "%.0f%%\n" $(echo $brightness \* 100 | bc))
notify-send "Brightness" "$brightness_percent" -r $NOTIFY_ID

echo -n $brightness >/tmp/display_brightness
xrandr --output $display --brightness $brightness
