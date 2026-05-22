#!/bin/bash

# server1 -> server2 -> main


echo "[ INFO ] 모든 서버 끄기 시작"
for host in server1 server2
do
    ping -c 1 -W 1 $host > /dev/null 2>$1
    if [ $? -eq 0 ]; then
    echo "[ INFO ] $host 서버 끄기"
    ssh $host poweroff
    sleep 3
    else
        echo "[ FAIL ] $host daed"
    fi
done
