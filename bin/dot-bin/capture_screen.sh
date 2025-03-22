#!/usr/bin/sh
# ffmpeg -f pulse -i 1 -f x11grab -i :0.0 -s 1920x1080 -r 30 -qp 0 -y -progress pipe:1 output.mp4

filenam
duration=$1
# filename=$(date --iso-8601=seconds | cut -d+ -f 1 | tr "T" "-" | tr ":" "-")
# filename=$filename.mp4
filename=$2
# echo $filename
#

notify-send "Screen Capture in" --urgency=low

for i in $(seq 5 -1 1); do
  echo "Screen Capture in $i seconds"
  notify-send "$i seconds ..." --urgency=critical
  sleep 1
done

dunstctl close-all

# ffmpeg -f pulse -t $duration -i 1 -f x11grab -t $duration -i :0.0 -c:v h264_amf -s 2560x1440 -r 30 -qp 0 -y -progress pipe:1 $filename
ffmpeg -f pulse -t $duration -i 1 -f x11grab -t $duration -i :0.0 -c:v h264_amf -s 1920x1080 -r 30 -qp 0 -y -progress pipe:1 $filename

if [ $? -eq 0 ]; then
  cpu_load=$(uptime | cut -d":" -f 5 | sed 's/^[ \t]*//')
  cpu_temp=$(echo $(cat /sys/class/hwmon/hwmon2/temp1_input)/1000 | bc)°C
  gpu_temp1=$(echo $(cat /sys/class/hwmon/hwmon1/temp1_input)/1000 | bc)°C
  gpu_temp2=$(echo $(cat /sys/class/hwmon/hwmon1/temp2_input)/1000 | bc)°C
  filename=$(pwd)/$filename
  filesize=$(ls -lh $filename | cut -d" " -f 5)
  fileduration=$(mediainfo --Inform="General;%Duration/String3%" $filename)
  # capture_end=$(date '+%Y-%m-%d %H:%M:%S')
  capture_end=$(date '+%H:%M:%S')
  notify-send "Screen Capture" "Done at $capture_end\n$filename\n$filesize $fileduration\nCPU Load: $cpu_load\nCPU Temp: $cpu_temp\nGPU Temp: $gpu_temp1 $gpu_temp2" \
    --urgency=low \
    --expire-time=0
else
  sleep 1
  notify-send "Screen Capture" "Failed\!" -u critical
fi
