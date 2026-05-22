#!/bin/bash

NET="10.1.93"

for i in $(seq 200 230)
do
    ping -c 1 -W 0.5 "$NET.$i" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $NET.$i"
    else
        echo "[ FAIL ] $NET.$i"
    fi
    
done


#강사님이 만드신 스크립트 파일
#자리 구성 편성으로 가독성이 좋음
#!/bin/bash

#START=200
#END=230
#NET=10.1.93
#FILE=/tmp/tmp1
#/bin/cp /root/bin/position.txt $FILE

#for i in $(seq $START $END)
#do
#    ping -c 1 -W 0.5 $NET.$i >/dev/null 2>&1 
#    if [ $? -eq 0 ]; then
#        echo "[  OK  ] $NET.$i"
#        sed -i "s/$i/$i:[0]/" $FILE
#    else
#        echo "[ FAIL ] $NET.$i"
#        sed -i "s/$i/$i:[X]/" $FILE
#    fi
#done

#cat << EOF
#=============== Classroom ===============
#$(cat $FILE)
#=========================================
#EOF