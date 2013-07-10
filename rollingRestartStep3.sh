#!/bin/bash

echo "About to start rolling restart LAST STEP(sleeping for 10 seconds first)"
sleep 10s

count=`cat files/webnodes.tmp | wc -l`
let count--

echo count=$count

temp=$((count+1))
echo temp=$temp

for (( i=1; i <= $count; i++ ))
do
   echo "Processing server index=$i"
   ./rollingRestartStepCommon.sh $i 1m
   ./rollingRestartStep2.sh
done
