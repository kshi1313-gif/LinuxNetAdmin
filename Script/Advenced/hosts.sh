#!/bin/bash

HOSTS=/root/bin/hosts
NET=10.1.93

for i in $(seq 200 230)
do
    echo "$NET.$i linux$i.example.com linux$i" >> $HOSTS
done
