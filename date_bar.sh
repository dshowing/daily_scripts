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

#cat bar_data.json
：‘
[
	{"date": "11-30", "value": 2119},
      	{"date": "12-01", "value": 5923},
       	{"date": "12-02", "value": 1393},
       	{"date": "12-03", "value": 600},
       	{"date": "12-04", "value": 2081},
       	{"date": "12-05", "value": 5384},
       	{"date": "12-06", "value": 4480},
       	{"date": "12-07", "value": 964},
       	{"date": "12-08", "value": 450},
       	{"date": "12-09", "value": 9342},
       	{"date": "12-10", "value": 7206},
       	{"date": "12-11", "value": 5673},
       	{"date": "12-12", "value": 520},
       	{"date": "12-13", "value": 4555}
]
’
