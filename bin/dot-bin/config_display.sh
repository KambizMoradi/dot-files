#/usr/bin/sh
xrandr --output eDP-1 --off --output DP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off

set_display_brightness.sh $main_display 0.8
