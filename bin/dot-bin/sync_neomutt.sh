#!/usr/bin/bash

success_time=5000
fail_time=8000

pkill mbsync
notify-send "Trying Sync Emails ..."

mw -Y
# ls
# ls .test

if [ $? -eq 0 ]; then
  notify-send "Emails Synced" \
    --urgency=low \
    --expire-time=$success_time
else
  notify-send "Cannot Sync Emails" \
    --urgency=critical \
    --expire-time=$fail_time
fi
