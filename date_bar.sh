#!/bin/bash
#User: dshowing

cur_dir=`pwd`
#echo $cur_dir
file_bar=$cur_dir'/bar-data.json'
#echo $file_bar

if [ ! -f "$file_bar" ];then
	echo "Check your curent_dir, make sure the file: bar_data.json"
	exit
fi
for ((i=13,j=2;i>=0;i--,j++));do
	his_date=`date "+%m-%d" -d "$i days ago"`
	echo $i
	echo $his_date
	sed -i ''"$j"'s/[0-9][0-9]-[0-9][0-9]/'"$his_date"'/' $file_bar
done
