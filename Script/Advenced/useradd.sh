#!/bin/bash

USERLIST=/root/bin/user.list

cat $USERLIST | while read UNAME UPASS
do
    # echo "$UNAME:$UPASS"
    useradd $UNAME
    echo "$UNAME:$UPASS" | chpasswd
    echo "[ OK ] $UNAME"
done



