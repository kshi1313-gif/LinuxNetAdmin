#!/bin/bash

# ==============================
# Telnet Login Test Script
# ==============================

SERVER_LIST="./server.list"
TIMEOUT=10

# server.list 파일 존재 확인
if [ ! -f "$SERVER_LIST" ]; then
    echo "[ FAIL ] $SERVER_LIST 파일이 존재하지 않습니다."
    exit 1
fi

# expect 설치 확인
if ! command -v expect &> /dev/null; then
    echo "[ FAIL ] expect 명령어가 없습니다."
    echo "설치 명령어: dnf install -y expect"
    exit 1
fi

echo "======================================"
echo " Telnet 접속 테스트 시작"
echo "======================================"

while read IP USER PASS
do
    # 빈 줄 또는 주석 줄 무시
    [[ -z "$IP" ]] && continue
    [[ "$IP" =~ ^# ]] && continue

    echo
    echo "--------------------------------------"
    echo "[ TEST ] $IP / 사용자: $USER"
    echo "--------------------------------------"

    expect << EOF
        set timeout $TIMEOUT

        spawn telnet $IP

        expect {
            "login:" {
                send "$USER\r"
            }
            "Username:" {
                send "$USER\r"
            }
            timeout {
                puts "[ FAIL ] $IP 접속 시간 초과"
                exit 1
            }
            eof {
                puts "[ FAIL ] $IP telnet 연결 실패"
                exit 1
            }
        }

        expect {
            "Password:" {
                send "$PASS\r"
            }
            "password:" {
                send "$PASS\r"
            }
            timeout {
                puts "[ FAIL ] $IP 패스워드 입력 대기 시간 초과"
                exit 1
            }
        }

        expect {
            "#" {
                puts "[ OK ] $IP root 계정 로그인 성공"
                send "exit\r"
            }
            "\\$" {
                puts "[ OK ] $IP 일반 사용자 로그인 성공"
                send "exit\r"
            }
            "Login incorrect" {
                puts "[ FAIL ] $IP 로그인 실패 - 계정 또는 패스워드 확인 필요"
                exit 1
            }
            timeout {
                puts "[ WARN ] $IP 로그인 여부 확인 불가"
                send "exit\r"
            }
        }

        expect eof
EOF

done < "$SERVER_LIST"

echo
echo "======================================"
echo " Telnet 접속 테스트 완료"
echo "======================================"
