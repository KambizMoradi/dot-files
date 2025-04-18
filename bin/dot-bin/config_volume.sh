#/usr/bin/bash

show_time=2000 # mili seconds

# get current volume
curent_volume=$(amixer -c 1 get Master | grep -oP '\[\d+%\]' | head -1 | tr -d '[]' | tr -d "%")

echo $1$2
if [ "$1" = "+" ]; then
  amixer -c 1 set Master $(echo "$curent_volume+$2" | bc)%
  curent_volume=$(amixer -c 1 get Master | grep -oP '\[\d+%\]' | head -1 | tr -d '[]' | tr -d "%")
  notify-send "Volume" "$curent_volume%" \
    --urgency=low \
    --expire-time=$show_time
elif [ "$1" = "-" ]; then
  amixer -c 1 set Master $(echo "$curent_volume-$2" | bc)%
  curent_volume=$(amixer -c 1 get Master | grep -oP '\[\d+%\]' | head -1 | tr -d '[]' | tr -d "%")
  notify-send "Volume" "$curent_volume%" \
    --urgency=low \
    --expire-time=$show_time
fi
