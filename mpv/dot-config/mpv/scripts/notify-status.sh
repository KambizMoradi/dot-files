#!/bin/bash
socket="/tmp/mpvsocket"
status=$(echo '{ "command": ["get_property", "pause"] }' | socat - "$socket" 2>/dev/null | jq -r .data)
if [ "$status" = "true" ]; then
  notify-send "MPV: 󰏤    " -r 9871634
else
  notify-send "MPV: 󰐊    " -r 9871634
fi
