#!/usr/bin/bash

NOTIFY_ID=127612367
NOTIFY_TIME=3000

if pidof antimicrox >/dev/null; then
  pkill antimicrox
  if [ $? -eq 0 ]; then
    echo "🎮 Disable Gamepad"
    notify-send "🎮 Disable" -u normal -r $NOTIFY_ID -t $NOTIFY_TIME
  else
    echo "☹️ Cannot Disable Gamepad"
    notify-send "☹️ Cannot Disable Gamepad" -u critical -t $NOTIFY_TIME
  fi
else
  antimicrox --hidden --tray --profile $cave_local_directory/antimicrox.gamecontroller.amgp >/dev/null 2>&1 &
  if [ $? -eq 0 ]; then
    echo "🎮 Enalbe Gamepad"
    notify-send "🎮 Enable" -u low -r $NOTIFY_ID -t $NOTIFY_TIME
  else
    echo "☹️ Cannot Enable Gamepad"
    notify-send "☹️ Cannot Enable Gamepad" -u critical -t $NOTIFY_TIME
  fi
fi
