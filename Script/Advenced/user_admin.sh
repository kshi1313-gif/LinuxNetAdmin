#!/bin/bash

# Variable Definition
PASSWD=/etc/passwd

# Function Definition
Menu() {
    cat <<'EOF'
(관리 목록)
------------------------------------
1) 사용자 추가
2) 사용자 확인
3) 사용자 삭제
4) 종료
------------------------------------
EOF
}

UserADD() {
    echo "(사용자 추가)"
    echo -n "추가할 사용자 이름? : "
    read UNAME

    useradd $UNAME \
        && echo "[ OK ] $UNAME" \
        && echo "$UNAME:$UNAME" | chpasswd \
        || echo "[ FAIL ] $UNAME"
}

UserVerify() {
    cat <<EOF
(사용자 확인)
-------------------------------
$(cat $PASSWD \
    | awk -F: '$3 >= 1000 && $3 <= 60000 {print$1}' \
    | nl)
-------------------------------
EOF
}

UserDel() {
    echo "(사용자 삭제)"
    echo -n "삭제할 사용자 이름? : "
    read UNAME

    userdel -r $UNAME
    [ $? -eq 0 ] \
        && echo "[ OK ] $UNAME" \
        || echo "[ FAIL ] $UNAME"
}

while true
do
    Menu
    echo -n "선택 번호?(1|2|3|4) : "
    read NUM
    echo

    # echo $NUM () 테스트
    case $NUM in
        1) UserADD ;;
        2) UserVerify ;;
        3) UserDel ;;
        4) break ;;
        *) echo "[ FAIL ] (1|2|3|4): 잘못된 입력($NUM)"
    esac
    echo
done



