#!/bin/bash
FILE=$1
for i in `awk -F: '{ print $1 }' $FILE`
do
    /usr/sbin/useradd $i -g ComputerArithmetic
    grep $i $FILE | cut -d":" -f2 | passwd --stdin $i
done
