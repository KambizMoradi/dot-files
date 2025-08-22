#/usr/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off

set_display_brightness.sh "eDP-1" 0.6

config_wallpapers.sh

function cpu_set_frequency {
  echo set spu frequency to $1 ...
  sudo cpupower frequency-set --max $1
  cpupower frequency-info --freq
}

cpu_set_frequency 1500000
