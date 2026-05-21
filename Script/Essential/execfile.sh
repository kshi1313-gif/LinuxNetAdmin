#!/bin/bash

echo -n "Enter Your Filename : "
read FILE1
echo

:<<EOF
#echo $FILE1
if [ -x $FILE1 ]; then
    $FILE1
fi
EOF

[ -x $FILE1 ] && $FILE1
