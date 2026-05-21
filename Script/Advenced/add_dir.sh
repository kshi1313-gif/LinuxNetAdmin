#!/bin/bash

BASEDIR=/test
mkdir -p /test && rm -rf /test/*

for i in 1 2 3 4
do
    #echo $i
    mkdir -p $BASEDIR/$i
    for j in 1 2 3 4
    do
        mkdir -p $BASEDIR/$i/$j
    done
done

tree -F $BASEDIR

