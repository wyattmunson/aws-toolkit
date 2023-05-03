#!/bin/bash

COUNT=$(echo "${#1}")
BUFFER_COUNT=$(($COUNT + 6))

repeat(){
        BAR=""
        for i in $(eval " echo {1.."$(($BUFFER_COUNT))"}")
        do
            BAR=$BAR"="
        done
        echo $BAR
}

echo ""
repeat
echo "= " $1 " ="
repeat
echo ""