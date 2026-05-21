#!/bin/bash

# ==========================================================
# Linux Account Manager TUI
# Bash + dialog 기반 사용자 계정 관리 스크립트
# Environment: CentOS / RHEL 계열
# ==========================================================

# ----------------------------------------------------------
# Variable Definition
# ----------------------------------------------------------
PASSWD="/etc/passwd"
TMPFILE="/tmp/account_userlist.txt"
LOGFILE="/var/log/account_manager_tui.log"
BACKTITLE=" Linux Account Manager TUI | CentOS User Management "

# ----------------------------------------------------------
# dialog 설치 확인
# ----------------------------------------------------------
CheckDialog() {
    if ! command -v dialog &>/dev/null; then
        echo "[ FAIL ] dialog 프로그램이 설치되어 있지 않습니다."
        echo
        echo "설치 명령어:"
        echo "  dnf install -y dialog"
        echo
        exit 1
    fi
}

# ----------------------------------------------------------
# root 권한 확인
# ----------------------------------------------------------
CheckRoot() {
    if [ "$EUID" -ne 0 ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Permission Error " \
               --msgbox "\n이 스크립트는 root 권한으로 실행해야 합니다.\n\n실행 예시:\n\n  sudo ./account_manager_tui.sh\n\n또는 root 계정으로 실행하세요." 14 65
        clear
        exit 1
    fi
}

# ----------------------------------------------------------
# 로그 기록 함수
# ----------------------------------------------------------
WriteLog() {
    echo "$(date '+%F %T') - $1" >> "$LOGFILE"
}

# ----------------------------------------------------------
# 사용자 이름 형식 검증 함수
# ----------------------------------------------------------
CheckUserName() {
    if [[ ! "$1" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Input Error " \
               --msgbox "\n사용자 이름 형식이 올바르지 않습니다.\n\n사용 가능 예시:\n\n  user01\n  test_user\n  linux-admin\n\n권장 규칙:\n\n  - 영문 소문자 또는 _ 로 시작\n  - 이후에는 영문 소문자, 숫자, _, - 사용 가능" 18 70
        return 1
    fi

    return 0
}

# ----------------------------------------------------------
# 시작 화면
# ----------------------------------------------------------
StartScreen() {
    dialog --clear \
           --backtitle "$BACKTITLE" \
           --title " Welcome " \
           --msgbox "\n========================================\n        Linux Account Manager TUI\n========================================\n\nBash와 dialog를 활용한 사용자 계정 관리 도구입니다.\n\n제공 기능:\n\n  [ADD]   사용자 추가\n  [VIEW]  사용자 목록 확인\n  [DEL]   사용자 삭제\n  [LOG]   작업 로그 확인\n\nEnter 키를 누르면 메인 메뉴로 이동합니다." 20 70
}

# ----------------------------------------------------------
# 사용자 추가 함수
# ----------------------------------------------------------
UserADD() {
    UNAME=$(dialog --clear \
                   --backtitle "$BACKTITLE" \
                   --title " [ADD] User Create " \
                   --inputbox "\n생성할 사용자 계정명을 입력하세요.\n\n예시:\n  user01\n  test_user\n  linux-admin" 14 65 \
                   2>&1 >/dev/tty)

    # 취소 버튼 또는 ESC 처리
    if [ $? -ne 0 ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Canceled " \
               --msgbox "\n사용자 추가 작업이 취소되었습니다." 8 50
        return
    fi

    # 빈 값 확인
    if [ -z "$UNAME" ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Input Error " \
               --msgbox "\n사용자 이름이 입력되지 않았습니다." 8 50
        return
    fi

    # 사용자 이름 형식 검증
    CheckUserName "$UNAME" || return

    # 기존 사용자 확인
    if id "$UNAME" &>/dev/null; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Duplicate User " \
               --msgbox "\n이미 존재하는 사용자입니다.\n\n사용자명: $UNAME" 10 55
        return
    fi

    # 비밀번호 입력
    UPASS=$(dialog --clear \
                   --backtitle "$BACKTITLE" \
                   --title " [ADD] Password Setting " \
                   --insecure \
                   --passwordbox "\n$UNAME 사용자의 초기 비밀번호를 입력하세요." 11 60 \
                   2>&1 >/dev/tty)

    if [ $? -ne 0 ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Canceled " \
               --msgbox "\n비밀번호 입력이 취소되었습니다." 8 50
        return
    fi

    if [ -z "$UPASS" ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Input Error " \
               --msgbox "\n비밀번호가 입력되지 않았습니다." 8 50
        return
    fi

    # 최종 확인
    dialog --clear \
           --backtitle "$BACKTITLE" \
           --title " Confirm User Create " \
           --yesno "\n다음 사용자를 생성하시겠습니까?\n\n  USERNAME : $UNAME\n\n생성 후 입력한 초기 비밀번호가 설정됩니다." 13 65

    if [ $? -ne 0 ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Canceled " \
               --msgbox "\n사용자 추가가 취소되었습니다." 8 50
        return
    fi

    # 사용자 생성
    useradd "$UNAME"

    if [ $? -eq 0 ]; then
        # 비밀번호 설정
        echo "$UNAME:$UPASS" | chpasswd

        if [ $? -eq 0 ]; then
            dialog --clear \
                   --backtitle "$BACKTITLE" \
                   --title " Success " \
                   --msgbox "\n[ OK ] 사용자 생성 완료\n\n  USERNAME : $UNAME\n\n작업 로그:\n  $LOGFILE" 13 65

            WriteLog "[ OK ] UserADD: $UNAME"
        else
            # 비밀번호 설정 실패 시 생성된 사용자 롤백
            userdel -r "$UNAME" &>/dev/null

            dialog --clear \
                   --backtitle "$BACKTITLE" \
                   --title " Failed " \
                   --msgbox "\n[ FAIL ] 비밀번호 설정 실패\n\n생성된 사용자 계정을 다시 삭제했습니다.\n\n  USERNAME : $UNAME" 13 65

            WriteLog "[ FAIL ] PasswordSet: $UNAME / rollback userdel"
        fi
    else
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Failed " \
               --msgbox "\n[ FAIL ] 사용자 생성 실패\n\n  USERNAME : $UNAME" 10 60

        WriteLog "[ FAIL ] UserADD: $UNAME"
    fi
}

# ----------------------------------------------------------
# 사용자 확인 함수
# ----------------------------------------------------------
UserVerify() {
    {
        echo "================================================================================"
        echo "                         Local User Account List"
        echo "================================================================================"
        printf "%-5s %-18s %-8s %-28s %-22s\n" "NO" "USER" "UID" "HOME" "SHELL"
        printf "%-5s %-18s %-8s %-28s %-22s\n" "--" "----" "---" "----" "-----"
        awk -F: '$3 >= 1000 && $3 <= 60000 {
            count++
            printf "%-5d %-18s %-8s %-28s %-22s\n", count, $1, $3, $6, $7
        }' "$PASSWD"
        echo "================================================================================"
    } > "$TMPFILE"

    # 일반 사용자가 없을 때
    if ! awk -F: '$3 >= 1000 && $3 <= 60000 {found=1} END {exit !found}' "$PASSWD"; then
        {
            echo "================================================================================"
            echo "                         Local User Account List"
            echo "================================================================================"
            echo
            echo "일반 사용자 계정이 없습니다."
            echo
            echo "UID 1000 ~ 60000 범위의 사용자를 일반 사용자로 조회합니다."
            echo "================================================================================"
        } > "$TMPFILE"
    fi

    dialog --clear \
           --backtitle "$BACKTITLE" \
           --title " [VIEW] User List " \
           --textbox "$TMPFILE" 22 90

    WriteLog "[ OK ] UserVerify"
}

# ----------------------------------------------------------
# 사용자 삭제 함수
# ----------------------------------------------------------
UserDel() {
    UNAME=$(dialog --clear \
                   --backtitle "$BACKTITLE" \
                   --title " [DEL] User Delete " \
                   --inputbox "\n삭제할 사용자 계정명을 입력하세요.\n\n주의:\n  삭제 시 홈 디렉터리도 함께 삭제됩니다.\n\n예시:\n  user01" 15 65 \
                   2>&1 >/dev/tty)

    if [ $? -ne 0 ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Canceled " \
               --msgbox "\n사용자 삭제 작업이 취소되었습니다." 8 50
        return
    fi

    if [ -z "$UNAME" ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Input Error " \
               --msgbox "\n사용자 이름이 입력되지 않았습니다." 8 50
        return
    fi

    # 사용자 이름 형식 검증
    CheckUserName "$UNAME" || return

    # 사용자 존재 여부 확인
    if ! id "$UNAME" &>/dev/null; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Not Found " \
               --msgbox "\n존재하지 않는 사용자입니다.\n\n  USERNAME : $UNAME" 10 55
        return
    fi

    # 삭제 확인
    dialog --clear \
           --backtitle "$BACKTITLE" \
           --title " Confirm User Delete " \
           --yesno "\n정말로 다음 사용자를 삭제하시겠습니까?\n\n  USERNAME : $UNAME\n\n주의:\n  userdel -r 명령으로 홈 디렉터리도 함께 삭제됩니다.\n\n이 작업은 되돌리기 어렵습니다." 16 70

    if [ $? -ne 0 ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Canceled " \
               --msgbox "\n사용자 삭제가 취소되었습니다." 8 50
        return
    fi

    userdel -r "$UNAME"

    if [ $? -eq 0 ]; then
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Success " \
               --msgbox "\n[ OK ] 사용자 삭제 완료\n\n  USERNAME : $UNAME\n\n작업 로그:\n  $LOGFILE" 13 65

        WriteLog "[ OK ] UserDel: $UNAME"
    else
        dialog --clear \
               --backtitle "$BACKTITLE" \
               --title " Failed " \
               --msgbox "\n[ FAIL ] 사용자 삭제 실패\n\n  USERNAME : $UNAME\n\n확인 사항:\n  - 사용자가 로그인 중인지 확인\n  - 실행 권한 확인\n  - 홈 디렉터리 상태 확인" 15 70

        WriteLog "[ FAIL ] UserDel: $UNAME"
    fi
}

# ----------------------------------------------------------
# 로그 확인 함수
# ----------------------------------------------------------
LogView() {
    if [ ! -f "$LOGFILE" ]; then
        echo "$(date '+%F %T') - [ INFO ] Log file created" > "$LOGFILE"
    fi

    dialog --clear \
           --backtitle "$BACKTITLE" \
           --title " [LOG] Operation Log " \
           --textbox "$LOGFILE" 22 90
}

# ----------------------------------------------------------
# 종료 화면
# ----------------------------------------------------------
ExitScreen() {
    dialog --clear \
           --backtitle "$BACKTITLE" \
           --title " Exit " \
           --msgbox "\nLinux Account Manager TUI를 종료합니다.\n\n작업 로그 위치:\n\n  $LOGFILE\n\n수고하셨습니다." 13 65
    clear
}

# ----------------------------------------------------------
# 메인 메뉴 함수
# ----------------------------------------------------------
MainMenu() {
    while true
    do
        CHOICE=$(dialog --clear \
                        --backtitle "$BACKTITLE" \
                        --title " Main Menu " \
                        --menu "\n원하는 작업을 선택하세요.\n\n방향키로 이동하고 Enter 키로 선택합니다.\nESC 또는 Cancel 선택 시 프로그램이 종료됩니다." 18 75 7 \
                        1 "[ADD]   사용자 추가" \
                        2 "[VIEW]  사용자 목록 확인" \
                        3 "[DEL]   사용자 삭제" \
                        4 "[LOG]   작업 로그 확인" \
                        5 "[EXIT]  프로그램 종료" \
                        2>&1 >/dev/tty)

        # Cancel 또는 ESC 처리
        if [ $? -ne 0 ]; then
            ExitScreen
            exit 0
        fi

        case "$CHOICE" in
            1)
                UserADD
                ;;
            2)
                UserVerify
                ;;
            3)
                UserDel
                ;;
            4)
                LogView
                ;;
            5)
                ExitScreen
                exit 0
                ;;
            *)
                dialog --clear \
                       --backtitle "$BACKTITLE" \
                       --title " Input Error " \
                       --msgbox "\n잘못된 메뉴 선택입니다." 8 45
                ;;
        esac
    done
}

# ==========================================================
# Main
# ==========================================================
CheckDialog
CheckRoot
StartScreen
MainMenu