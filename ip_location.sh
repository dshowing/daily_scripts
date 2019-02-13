#!/usr/bin/env bash
# IPs location: http://ip-api.com/json/

FILE=./ips

for ip in `cat $FILE`
do
  location=`/usr/bin/curl -s http://ip-api.com/json/$ip | awk -F '"' '{print $8}'`
  echo $ip" "$location >> ./location
done
