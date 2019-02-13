#!/use/bin/env bash
# A very big file, need to be translated in BeiJing timestamp.

#data_example
#1383575137
#1383575137
#1383575137
#1383575160
#1383575160
#1383575160
#1383575160
#1383575172
#1383575184
#1383575378

#Way 1
FILE=./data.csv
cat $FILE | while read op
do
  /usr/bin/date -d @$op > data_new.csv
done


#Way 2
#awk 'BEGIN{FS=","}{system("date " "-d " "@"$1)}' analyze_data.csv > analyze_data_time.csv
