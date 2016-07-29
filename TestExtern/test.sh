#！/bin/bash


echo "Hello world"
aname="cooper333"

echo $name

for skill in Java OC Php Python; do
 echo "I am a ${skill} developer!"
done


function square {
#local sq          #local是函数内部变量
sq=`expr $1 \*$1`
#sq=$[ $1 \* $1 ]
#sq=$(( $1 \* $1 ))
echo -e "the $1\047s square is $sq"
}

echo -n "please input a number"
read number
while ["$number" = ""]
do
echo error!please input a number
read number
done
square $number
echo REPLY=$?
re=$(square $number)
echo $re
