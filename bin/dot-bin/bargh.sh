#/usr/bin/sh
url2time() {
  rsl=$(cat $1 | jq '.data.[].period' | tr -d \" | sort | uniq | sed 's/،/\n/' | sort | tr '\n' ' ' | sed -e 's/ $//' -e 's/ /   /')
  if [[ ! "$rsl" =~ [0-9] ]]; then
    echo ""
    # do something here
  else
    echo "$rsl"
  fi
}

today=$(jdate +"%Y%%2F%m%%2F%d" -j $(date -d 'now' +"%Y/%m/%d"))
tomorrow=$(jdate +"%Y%%2F%m%%2F%d" -j $(date -d '+1 day' +"%Y/%m/%d"))

id_home=7366786510120
id_office=7351816410129

url_home_today="http://85.185.251.108:8007/home/popfeeder?date=$today&id=$id_home"
url_home_tomorrow="http://85.185.251.108:8007/home/popfeeder?date=$tomorrow&id=$id_home"

url_office_today="http://85.185.251.108:8007/home/popfeeder?date=$today&id=$id_office"
url_office_tomorrow="http://85.185.251.108:8007/home/popfeeder?date=$tomorrow&id=$id_office"

curl -s $url_home_today >/tmp/bargh_home_today
curl -s $url_home_tomorrow >/tmp/bargh_home_tomorrow
curl -s $url_office_today >/tmp/bargh_office_today
curl -s $url_office_tomorrow >/tmp/bargh_office_tomorrow

printf '%s\n' \
  ".TS" \
  "allbox,tab(@);" \
  "l C C." \
  "@Home@Office" \
  "$(jdate +"%a %Y-%m-%d")@$(url2time /tmp/bargh_home_today)@$(url2time /tmp/bargh_office_today)" \
  "$(jdate +"%a %Y-%m-%d" -j $(date -d "+1 day" +"%Y/%m/%d"))@$(url2time /tmp/bargh_home_tomorrow)@$(url2time /tmp/bargh_office_tomorrow)" \
  ".TE" | tbl | nroff -Tutf8 | sed '/^$/d'
