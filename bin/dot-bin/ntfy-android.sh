#!/usr/bin/sh
msg=$1
# msg='Hi Kami'

max_retry=50
counter=0

until ntfy publish $ntfy_android_token $msg; do
  sleep 1
  [[ counter -eq $max_retry ]] && echo "Failed!" && exit 1
  echo "Trying again. Try #$counter"
  ( (counter++))
done
