#!/usr/bin/env bash
#Auther: dshowing
#Email: watt109629@outlook.com

# exist or not
command -v cython >> /dev/null
if [ $? -eq 1 ]; then
  /usr/bin/apt-get install -y cython
fi

# jump to dir
jump(){
    echo "================================"
    echo "Curent DIR: `pwd`"
    encryption

    iso=`ls -l | grep drw | awk '{print $9}' | wc -l`
    if [ $iso -ne 0 ]; then
      for dir in `ls -l | grep ^drw | awk '{print $9}'`
      do
        cd $dir
        jump
        cd ../
      done
    fi
}

# run encryption
encryption(){
    is_py=`ls -l | grep *.py | grep -v __init | wc -l`
    if [ $is_py -ne 0 ]; then
      for file in `ls -l *.py | grep -v __init | awk '{print $9}'`
      do
        name=`echo $file | awk -F '.' '{print $1}'`
        /usr/bin/cython $file
        gcc -shared -pthread -fPIC -fwrapv -O2 -Wall -fno-strict-aliasing -I/usr/include/python2.7 -o $name".so" $name".c"

        rm -f $name".c" $name".py"
      done
    fi
}

jump
