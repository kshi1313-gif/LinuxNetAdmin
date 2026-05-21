#!/bin/bash

echo -n  "파일 이름은? : "
read FILE1

#echo $FILE1
if [ -f $FILE1 ]; then
    echo "[ OK ] 일반 파일"
elif [ -d $FILE1 ]; then
    echo "[ OK ] 디렉토리 파일"
else
    echo "[ FIAL ] 다른 종류의 파일"
fi
