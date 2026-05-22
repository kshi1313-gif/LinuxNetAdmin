#!/bin/bash

FTP_SERVER="10.1.93.10"
FTP_USER="user01"
FTP_PASS="user01"

LOCAL_DIR="/test"
LOCAL_FILE="testfile.txt"
REMOTE_DIR="Share"

echo "======================================"
echo " Linux -> Windows FTP Upload"
echo " Source      : $LOCAL_DIR/$LOCAL_FILE"
echo " Destination : Windows C:\\Share"
echo "======================================"

if [ ! -f "$LOCAL_DIR/$LOCAL_FILE" ]; then
    echo "[FAIL] 전송할 파일이 없습니다: $LOCAL_DIR/$LOCAL_FILE"
    exit 1
fi

ftp -n "$FTP_SERVER" << EOF
user $FTP_USER $FTP_PASS
bin
lcd $LOCAL_DIR
cd $REMOTE_DIR
put $LOCAL_FILE
quit
EOF

if [ $? -eq 0 ]; then
    echo "[OK] FTP 명령 실행 완료"
    echo "[CHECK] Windows C:\\Share 폴더에서 $LOCAL_FILE 파일을 확인하세요."
else
    echo "[FAIL] FTP 전송 실패"
fi