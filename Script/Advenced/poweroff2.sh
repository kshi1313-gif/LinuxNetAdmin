#!/bin/bash

#패키지 설치
yum -q -y install sshpass

# 서버 끄기
for i in server1 server2 #main
do
    ping -c 1 -W 1 $i >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[ INFO ] $i 전원끄기"
        sshpass -p 'soldesk1.' \
        ssh -o StrictHostKeyChecking=no $i poweroff
        sleep 3
    else
        echo "[ FAIL ] $i dead"
    fi
done


