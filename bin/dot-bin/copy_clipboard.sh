#!/usr/bin/sh

echo -e $(grep -v '^#' $XDG_DATA_HOME/myclipboard.txt | dmenu -i -l 50 | awk -F '-->' '{print $2}') | xclip -rmlastnl -selection clipbloard &
exit
