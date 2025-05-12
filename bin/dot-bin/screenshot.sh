#!/usr/bin/sh

file_name=$(date +"%Y-%m-%d-%H-%M-%S")
scrot --silent --ignorekeyboard --quality 100 --select "$screenshots_directory/$file_name.png" -e "xclip -selection clipboard -t image/png -i $screenshots_directory/$file_name.png;"
