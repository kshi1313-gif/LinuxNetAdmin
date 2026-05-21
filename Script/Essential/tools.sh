#!/bin/bash

cat <<EOF
====================================================
  (1). who      (2). date     (3). cal              
====================================================
EOF
echo -n "번호 입력(1|2|3)? : "
read NUM

# echo $NUM
case $NUM in
    1) who ;;
    2) date ;;
    3) cal ;;
    *) echo "[ FAIL ] 잘못된 선택"
       exit 1 ;;
esac
