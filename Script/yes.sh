#!/bin/bash

echo -n '당신의 선택은(y/n)? : '
read ANSWER

case $ANSWER in
    yes|y|YES|Yes|Y) echo "[ OK ] YES";;
    no|n|NO|No|N)   echo "[ OK ] NO" ;;
    *) echo "[ FAIL ] 땡"
       exit 1 ;;
esac


