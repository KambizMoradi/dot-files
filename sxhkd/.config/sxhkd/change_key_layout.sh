#!/usr/bin/sh

random_id=1239123
show_time=1000 # mili seconds
setxkbmap -query| grep layout| grep us >/dev/null
answer=$?
if [ $answer == 0 ]
then
    setxkbmap ir
    notify-send "ir" \
		--urgency=low \
		--replace-id=$random_id \
		--expire-time=$show_time
else
    setxkbmap us
    notify-send "us" \
		--urgency=low \
		--replace-id=$random_id \
		--expire-time=$show_time
fi
