#!/bin/bash

# chklog.sh /var/log/messages
if [ $# -ne 1 ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi    
LOG=$1

TMP1=/tmp/tmp1 && > $TMP1
TMP2=/tmp/tmp2 && > $TMP2
TMP3=/tmp/tmp3 && > $TMP3

#TMP1=$(mktemp->임시 파일을 생성해주는 명령어)

# 첫번째 임시파일
cat $LOG | egrep -i 'warn|fail|error|crit|alert|emerg' > $TMP1
while true
do
    sleep 10
    # 두번째 임시파일
    cat $LOG | egrep -i 'warn|fail|error|crit|alert|emerg' > $TMP2
    # 2개의 파일 비교
    diff $TMP1 $TMP2 > $TMP3 && continue
    [ -s $TMP3 ] \
        && mailx -s "[WARN] $LOG check" root < $TMP3
    # 첫번째 임시파일 다시 초기화 
    cat $LOG | egrep -i 'warn|fail|error|crit|alert|emerg' > $TMP1
done

