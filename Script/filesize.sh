#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 filename"
    exit 1
fi
FILE=$1

FILESIZE=$(wc -c < $FILE)
if [ $FILESIZE -ge 5120 ]; then
    echo "[ OK ] 큰놈($FILE)"
else
    echo "[ OK ] 작은놈($FILE)"
fi


