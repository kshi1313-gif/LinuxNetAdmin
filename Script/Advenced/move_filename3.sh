#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <directory> <extension1> <extension2>"
    exit 1
fi
D_WORK=$1   
EXT1=".$2"
EXT2=".$3"

T_FILE1=/tmp/.tmp1  	# tempory file1

find $D_WORK | grep "${EXT1}\$" > $T_FILE1
for FILE in `cat $T_FILE1`
do
    mv $FILE `echo $FILE | sed "s/${EXT1}\$/${EXT2}/g"`
done