#!/bin/bash

#############################################
# Dialog FTP Upload Script
# Linux /test/testfile.txt -> Windows C:\Share
#############################################

# dialog 설치 여부 확인
if ! command -v dialog >/dev/null 2>&1; then
    echo "[INFO] dialog 패키지가 설치되어 있지 않습니다."
    echo "[INFO] 설치를 진행합니다."
    yum -y install dialog
fi

# 임시 파일
TMP_FILE="/tmp/ftp_dialog_$$"

# 기본값
DEFAULT_FTP_SERVER="10.1.93.10"
DEFAULT_FTP_USER="user01"
DEFAULT_FTP_PASS="user01"
DEFAULT_LOCAL_DIR="/test"
DEFAULT_LOCAL_FILE="testfile.txt"
DEFAULT_REMOTE_DIR="Share"

# FTP 서버 IP 입력
dialog --title "FTP 서버 설정" \
--inputbox "Windows FTP 서버 IP를 입력하세요." 10 50 "$DEFAULT_FTP_SERVER" 2> "$TMP_FILE"

if [ $? -ne 0 ]; then
    clear
    echo "[CANCEL] 작업이 취소되었습니다."
    exit 1
fi

FTP_SERVER=$(cat "$TMP_FILE")

# FTP 사용자 입력
dialog --title "FTP 계정 설정" \
--inputbox "FTP 사용자 이름을 입력하세요." 10 50 "$DEFAULT_FTP_USER" 2> "$TMP_FILE"

if [ $? -ne 0 ]; then
    clear
    echo "[CANCEL] 작업이 취소되었습니다."
    exit 1
fi

FTP_USER=$(cat "$TMP_FILE")

# FTP 비밀번호 입력
dialog --title "FTP 비밀번호 설정" \
--passwordbox "FTP 비밀번호를 입력하세요." 10 50 "$DEFAULT_FTP_PASS" 2> "$TMP_FILE"

if [ $? -ne 0 ]; then
    clear
    echo "[CANCEL] 작업이 취소되었습니다."
    exit 1
fi

FTP_PASS=$(cat "$TMP_FILE")

# 로컬 디렉토리 입력
dialog --title "Linux 로컬 디렉토리" \
--inputbox "전송할 파일이 있는 Linux 디렉토리를 입력하세요." 10 60 "$DEFAULT_LOCAL_DIR" 2> "$TMP_FILE"

if [ $? -ne 0 ]; then
    clear
    echo "[CANCEL] 작업이 취소되었습니다."
    exit 1
fi

LOCAL_DIR=$(cat "$TMP_FILE")

# 로컬 파일명 입력
dialog --title "Linux 로컬 파일" \
--inputbox "전송할 파일명을 입력하세요." 10 60 "$DEFAULT_LOCAL_FILE" 2> "$TMP_FILE"

if [ $? -ne 0 ]; then
    clear
    echo "[CANCEL] 작업이 취소되었습니다."
    exit 1
fi

LOCAL_FILE=$(cat "$TMP_FILE")

# 원격 디렉토리 입력
dialog --title "Windows 저장 폴더" \
--inputbox "Windows FTP 서버의 저장 폴더명을 입력하세요.\n\n예: C:\\Share 인 경우 FTP 홈이 C:\\ 라면 Share 입력" 12 70 "$DEFAULT_REMOTE_DIR" 2> "$TMP_FILE"

if [ $? -ne 0 ]; then
    clear
    echo "[CANCEL] 작업이 취소되었습니다."
    exit 1
fi

REMOTE_DIR=$(cat "$TMP_FILE")

# 파일 존재 여부 확인
if [ ! -f "$LOCAL_DIR/$LOCAL_FILE" ]; then
    dialog --title "파일 확인 실패" \
    --msgbox "전송할 파일이 존재하지 않습니다.\n\n$LOCAL_DIR/$LOCAL_FILE" 10 60

    clear
    rm -f "$TMP_FILE"
    exit 1
fi

# 전송 정보 최종 확인
dialog --title "FTP 전송 정보 확인" \
--yesno "아래 정보로 파일을 전송하시겠습니까?\n\nFTP Server : $FTP_SERVER\nFTP User   : $FTP_USER\nSource     : $LOCAL_DIR/$LOCAL_FILE\nDestination: Windows C:\\$REMOTE_DIR\\$LOCAL_FILE" 15 70

if [ $? -ne 0 ]; then
    clear
    echo "[CANCEL] 사용자가 전송을 취소했습니다."
    rm -f "$TMP_FILE"
    exit 1
fi

# FTP 전송 실행
clear

echo "======================================"
echo " Linux -> Windows FTP Upload"
echo "======================================"
echo "FTP Server  : $FTP_SERVER"
echo "FTP User    : $FTP_USER"
echo "Source      : $LOCAL_DIR/$LOCAL_FILE"
echo "Destination : Windows C:\\$REMOTE_DIR"
echo "======================================"

ftp -n "$FTP_SERVER" << EOF
user $FTP_USER $FTP_PASS
bin
lcd $LOCAL_DIR
cd $REMOTE_DIR
put $LOCAL_FILE
quit
EOF

RESULT=$?

# 결과 출력
if [ $RESULT -eq 0 ]; then
    dialog --title "전송 완료" \
    --msgbox "FTP 명령이 완료되었습니다.\n\nWindows C:\\$REMOTE_DIR 폴더에서\n$LOCAL_FILE 파일을 확인하세요." 12 60

    clear
    echo "======================================"
    echo "[OK] FTP 명령 실행 완료"
    echo "[CHECK] Windows C:\\$REMOTE_DIR 폴더에서 $LOCAL_FILE 확인"
    echo "======================================"
else
    dialog --title "전송 실패" \
    --msgbox "FTP 전송 중 오류가 발생했습니다.\n\n확인 사항:\n1. Windows ALFTP 실행 여부\n2. FTP 계정/비밀번호\n3. Windows 방화벽\n4. C:\\$REMOTE_DIR 폴더 존재 여부\n5. Linux에서 FTP 접속 가능 여부" 15 70

    clear
    echo "======================================"
    echo "[FAIL] FTP 전송 실패"
    echo "======================================"
fi

# 임시 파일 삭제
rm -f "$TMP_FILE"