#!/usr/bin/env bash

# Define cleanup function
cleanup() {
  echo "Interrupted! Running cleanup..."
  pkill -f "mpv --input-ipc-server=/tmp/mpvsocket_play_sliced*"
  exit

  # put your custom command here
}

# Trap SIGINT (Ctrl+C)
trap cleanup SIGINT

pkill -f "mpv --input-ipc-server=/tmp/mpvsocket_play_sliced*"

mpv --input-ipc-server=/tmp/mpvsocket_play_sliced --idle=yes &
rm -f /tmp/play_sliced_*
for input in "$@"; do
  realinput=$(realpath "$input" | tr " " "_" | tr "/" "_")
  new_input="/tmp/play_sliced_track$realinput"
  cp "$input" "$new_input"
  # echo $input
  starts="/tmp/play_sliced_silence_starts$realinput.txt"
  ends="/tmp/play_sliced_silence_ends$realinput.txt"
  slices="/tmp/play_sliced_slices$realinput.txt"

  echo 0>>$starts

  # Get duration of file
  ffmpeg -i $new_input -af silencedetect=noise=-50dB:d=0.2 -f null - 2>&1 | grep -E "silence_start" | cut -d':' -f2 | tr -d ' ' >>$starts
  duration=$(ffprobe -i $new_input -show_entries format=duration -v quiet -of csv="p=0")

  tail -n +2 $starts >$ends
  echo $duration >>$ends

  paste -d"," $starts $ends >$slices
  number_of_parts=$(cat $slices | wc -l)

  rm -f $starts $ends

  i=0

  offset=0.2
  for line in $(cat $slices); do
    i=$((i + 1))
    full_name=$(echo ${realinput%.*})
    name=$(printf "/tmp/play_sliced%s_%09d.mp3" "$full_name" "$i")
    title=$(printf "%s section: %d/%d" "$input" "$i" "$number_of_parts")

    start=$(echo $line | cut -d"," -f1)
    start=$(echo "$start +$offset" | bc -l)

    end=$(echo $line | cut -d"," -f2)
    end=$(echo "$end +$offset" | bc -l)

    len=$(echo "$end - $start" | bc -l)
    ffmpeg -y -i "$input" -ss "$start" -t "$len" -metadata title="$title" $name >/dev/null 2>&1
    echo $line
    echo "part: $i name:$name start: $start end: $end length: $len"
    echo '{ "command": ["loadfile", "'$name'", "append"] }' | socat - /tmp/mpvsocket_play_sliced >/dev/null 2>&1
    # echo "{ 'command': ['loadfile', '$name', 'append'] }"
  done
  rm -f $new_input
  rm -f $slices
done
