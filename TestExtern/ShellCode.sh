#!/bin/sh

#  ShellCode.sh
#  PracticeDemo
#
#  Created by mac on 16/7/26.
#  Copyright © 2016年 keyrun. All rights reserved.


#！/bin/bash

#var

name="cooper"
echo $name
for skill in java objectc python; do
echo "i am a ${skill} developer"
done

readonly url="www.baidu.com"         #只读
echo ${url}

declare -i a=10            # declare 声明变量 -i整数  -a数组 -r只读 -x全局变量
declare -i b=2#101         #2进制  值是101 == 5

export AVAR="全局变量"      # export 声明全局变量

echo ${export -p}

unset name

echo ${name:-^_^}

echo ${name:}

echo $name



#string

newname="chris"
printstr="hello,\"${newname}\"\n"

echo $printstr
echo ${newname:0:2}
echo '$newname'
echo `date`

string="hello"
echo ${#string}
#echo `expr index "${string}" ll`

string="runoob is a great company"
echo `expr index "$string" is`

#array 元素间用空格
array=("a" "bb" c)
array2=(java python oc)
echo ${array[@]}            #获取数组所有元素
echo ${array[*]}
echo ${#array[@]}           #数组元素个数
echo ${#array2[1]}           #1位置元素的长度
for var in array; do
echo ${var}
done

#接收传递的参数  执行/bin/sh test.sh 1 2
echo "接收第一个参数$0"
echo "接收第二个参数$1"
echo "接收第三个参数$2"
#输出 XXtest.sh  XX1  XX2

echo $#             #接收参数的个数
echo "$*"           #以一个单字符显示所有接收的参数 '1 2'
echo "$@"           #打印每个参数 '1' '2'

for i in "$*"; do
echo $i
done


#运算符   expr 能完成表达式的求值操作

echo " 加法: `expr 2 + 3` "

echo " 乘法: `expr 2 \* 4` "    #乘法 要加\

a=1
b=3
if [ $a != $b ]
then
echo "a != b"
fi


#关系运算符    只对数字 等于（-eq）大于（-gt）小于（-lt）大等于（-ge）小等于（-le）

if [ $a -eq $b ]
then
echo "a == b"
else
echo "a != b"
fi


#布尔运算符   非（!）  或（-o ，||） 与（-a，&&）

if [ $a -le 3 -a $b -ge 1 ]
then
echo "a小于等于3 且 b大于等于1"
fi

if [[ $a -le 3 || $b -ge 1 ]]
then
echo "a小于等于3 或 b大于等于1"
fi


#字符串运算符  = ,!= ,-z(长度是否是0) ,str(是否为空)

m="abc"
n="jkl"

if [ $n ]
then
echo "n 不为空"
elif [ $m -z ]
then
echo "m 长度大于1"
fi


#文件操作   -e（是否存在）,-d（是否是文件夹）, -x(是否可执行), -w,-r （可写，可读）
file="/Users/macbook/Documents/codeFolder/ExternDemo/TestExtern/ShellCode.sh"
if [ -e $file ]
then
echo "存在文件"
else
echo "文件不存在"
fi


#printf    使用格式: printf + format-string + [arg...]

printf "%d %s\n" 2 "abc"

printf "%-10s %-4.2f \n" cooper 12.0213  3.2313       #-10s表示宽度为限制为10字符


#函数
dofunction(){
   echo " shell function "
   echo " 第一个参数是 $1 "
   echo "输入第一个数字: "
   read anum
   echo "输入第二个数字: "
   read bnum
   return $(($anum + $bnum))
}

dofunction 1 2
dofunction 2 3
echo "求和 == $? "        # $?获取函数的返回值



#引用另外的shell文件
source ./test.sh
echo "name == ${aname}"


# unset -f function_name
# export -f function_name





