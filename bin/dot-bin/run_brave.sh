#!/usr/bin/sh

brave $(grep -v '^#' $XDG_DATA_HOME/mybookmarks.txt | dmenu -i -l 50 | awk -F '-->' '{print $2}') &
exit
