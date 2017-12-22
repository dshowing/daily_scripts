#!/bin/bash
#def by dshowing

i=1

while [ $i -le 10000 ]
do
a=`echo `< /dev/urandom tr -dc A-Za-z0-9 | head -c6``
echo -n -e "$a\t"
b=`echo `< /dev/urandom tr -dc 0-9 | head -c6``
echo "$b"
i=`expr $i + 1`
done
