#!/usr/bin/sh

pkill xdotool
xdotool type $(grep -v '^#' $XDG_DATA_HOME/myclipboard.txt | dmenu -i -l 50 | awk -F '-->' '{print $2}')
pkill xdotool
exit
