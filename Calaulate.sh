#!/bin/bash
#simple calculater
#def by dshowing

num_input() {
    while :
    do 
    read -p "first num :" a
    expr $a + 0 &> /dev/null
    if [ $? -eq 0 ]; then
        echo "The first num is : $a"
        break
    else 
        echo "$a is not a int var. Try again."
    fi
    done

    while :
    do
    read -p "second num :" b
    expr $b + 0 &> /dev/null
    if [ $? -eq 0 ]; then
        echo "The second num is : $b"
        break
    else
        echo "$b is not a int var. Try again."
    fi
    done

}


echo "======================="
echo "|        1.ADD        |"
echo "|        2.SUB        |"
echo "|        3.MUL        |"
echo "|        4.DIV        |"
echo "======================="


read -p "Choose your action :"  Act
case $Act in
1)
    num_input
    res=`expr $a + $b`
    echo "$a + $b = $res"
;;
2)
    num_input
    res=`expr $a - $b`
    echo "$a + $b = $res"
;;
3)
    num_input
    res=`expr $a * $b`
    echo "$a * $b = $res"
;;
4)
    num_input
    res=`expr $a / $b`
    echo "$a / $b = $res"
;;
*)
    echo "Input Error !"
esac
