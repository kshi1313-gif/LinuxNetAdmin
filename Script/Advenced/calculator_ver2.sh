#!/bin/bash

echo -n 'Enter A : '
read A

echo -n 'Enter Operator : '
read OP

echo -n 'Enter C : '
read C

case $OP in
    '+') echo "$A + $C = $(( $A + $C ))" ;;
    '-') echo "$A - $C = $(( $A * $C ))" ;;
    '*') echo "$A x $C = $(( $A * $C ))" ;;
    '/') echo "$A / $C = $(( $A / $C ))" ;;
    *) echo "Usage: $A +|-|*|/ $C"
       exit 1;;
esac


