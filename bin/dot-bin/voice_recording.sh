#!/bin/bash

set -e

# Directory to store recordings
RECORDINGS_DIR="$recordings_directory"
FILE_NAME_FILE="/tmp/recordeding_file_name.txt"
STATE_FILE="/tmp/recording_stat.txt" # Track the current mode (recording/playing)

REC="⏺ REC"
PLAY="▶ PLAY"
STOP="⏹ STOP"

PRE_TRIM=0.2
POST_TRIM=-0.0

PLAY_LOOP_PID=""
PLAY_LOOP_PID_FILE="/tmp/play_loop_pid.txt"

NOTIFY_TIME=999999999
NOTIFY_ID=98719236

trap cleanup INT

cleanup() {
  stop_playing
  stop_recording
  notify-send "$STOP" -u normal -r $NOTIFY_ID -t 3000
  echo -e "$STOP"
  exit 0
}

# Function to get the current timestamp in the format YYYYMMDD_HHMMSS
get_timestamp() {
  date +"%Y-%m-%d-%H-%M-%S"
}

start_recording() {
  echo "recording" >"$STATE_FILE" # Save state
  pkill paplay 2>/dev/null || true
  notify-send "$REC" -u critical -r $NOTIFY_ID -t $NOTIFY_TIME
  echo -e -n "\e[1;37;41m$REC\e[0m "

  TIMESTAMP=$(get_timestamp)
  AUDIO_FILE="$RECORDINGS_DIR/$TIMESTAMP.wav"
  echo "$AUDIO_FILE" >"$FILE_NAME_FILE"
  parecord --file-format=wav "$AUDIO_FILE" &
}

stop_recording() {
  echo "stopped" >"$STATE_FILE"
  pkill paplay 2>/dev/null || true
  pkill parecord 2>/dev/null || true
}

start_playing_loop() {
  echo "playing" >"$STATE_FILE"

  notify-send "$PLAY" -u low -r $NOTIFY_ID -t $NOTIFY_TIME
  echo -e "\e[1;37;42m$PLAY\e[0m "

  pkill parecord 2>/dev/null || true
  AUDIO_FILE=$(cat "$FILE_NAME_FILE")
  state=$(cat "$STATE_FILE")
  (
    while [[ "$state" == "playing" ]]; do
      paplay "$AUDIO_FILE" &
      wait $!
      state=$(cat "$STATE_FILE")
    done
  ) &
}

stop_playing() {
  echo "stopped" >"$STATE_FILE"
  pkill paplay 2>/dev/null || true
  pkill parecord 2>/dev/null || true
}

toggle_mode() {
  if [[ -f "$STATE_FILE" ]]; then
    state=$(cat "$STATE_FILE")
    if [[ "$state" == "recording" ]]; then
      stop_recording
      # Trim first and last 200ms of the recording
      TRIMMED_FILE="/tmp/voice_loop_trimmed.wav"
      AUDIO_FILE=$(cat "$FILE_NAME_FILE")
      sox "$AUDIO_FILE" "$TRIMMED_FILE" trim $PRE_TRIM $POST_TRIM
      mv "$TRIMMED_FILE" "$AUDIO_FILE"
      start_playing_loop
    elif [[ "$state" == "playing" ]]; then
      stop_playing
      start_recording
    elif [[ "$state" == "stopped" ]]; then
      stop_playing
      start_recording
    fi
  else
    start_recording
  fi
}

# Main logic
if [[ -z "$1" ]]; then
  # No argument, start recording
  echo -e "\e[1;37;41m[SPACE]: $REC\e[0m \e[1;37;42m[SPACE]: $PLAY\e[0m  [CTRL+c]: $STOP"

  # Main loop: listen for keypresses
  while true; do
    IFS= read -rsn1 key
    if [[ "$key" == " " ]]; then
      toggle_mode
    fi
  done
elif [[ "$1" == "toggle" ]]; then
  # Toggle behavior (start recording, or stop and start playing)
  toggle_mode
elif [[ "$1" == "stop" ]]; then
  # Stop all processes
  cleanup
else
  echo "Usage: $0 {toggle|stop}"
  exit 1
fi
