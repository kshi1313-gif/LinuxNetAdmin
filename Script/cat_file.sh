#!/bin/bash

FTPUSERS=/etc/vsftpd/ftpusers

for NAME in $(cat $FTPUSERS | egrep -v '^$|^#')
do
    echo "[ DENY ] $NAME"
done

