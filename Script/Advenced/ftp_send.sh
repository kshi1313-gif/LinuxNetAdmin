#!/bin/bash

# 전송 대상 IP 목록
TARGETS="10.1.93.208 10.1.93.207 10.1.93.205"

# FTP 계정 정보
FTP_USER="user01"
FTP_PASS="user01"

# 내 PC에서 보낼 파일들이 있는 디렉토리
LOCAL_DIR="/test"

# 상대방 PC에 저장할 디렉토리
REMOTE_DIR="/tmp"

# 전송할 파일명
SEND_FILE="testfileksh.txt"

for IP in $TARGETS
do
    echo "===================================="
    echo "$IP 서버로 파일 전송 시작"
    echo "로컬 경로: $LOCAL_DIR/$SEND_FILE"
    echo "원격 경로: $REMOTE_DIR/$SEND_FILE"
    echo "===================================="

ftp -n $IP 21 << EOF
user $FTP_USER $FTP_PASS
cd $REMOTE_DIR
lcd $LOCAL_DIR
bin
hash
prompt
mput $SEND_FILE
quit
EOF

    echo "$IP 서버로 파일 전송 완료"
    echo
done
