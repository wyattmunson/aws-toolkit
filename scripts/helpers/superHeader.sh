#!/bin/bash

HEADER_CHAR_COUNT=$(echo "${#1}")
# HEADER_BUFFER_COUNT=$(($HEADER_CHAR_COUNT + 6))
SUB_CHAR_COUNT=$(echo "${#2}")
SUB_BUFFER_COUNT=$(($SUB_CHAR_COUNT + 6))
SIDE_HEADER_BUFFER=$(((($SUB_BUFFER_COUNT - $HEADER_CHAR_COUNT) / 2 ) - 1 ))

echo $HEADER_CHAR_COUNT
echo $SUB_CHAR_COUNT
echo $SUB_BUFFER_COUNT
echo $SIDE_HEADER_BUFFER

repeat(){
        BAR=""
        for i in $(eval " echo {1.."$(($SUB_BUFFER_COUNT))"}")
        do
            BAR=$BAR"="
        done
        echo $BAR
}

getHeaderBar() {
    BAR="="
    for i in $(eval " echo {1.."$(($SIDE_HEADER_BUFFER))"}")
    do
        BAR=$BAR" "
    done

    BAR+="${1}"
    for i in $(eval " echo {1.."$(($SIDE_HEADER_BUFFER))"}")
    do
        BAR=$BAR" "
    done

    echo $BAR

}

echo ""
repeat
getHeaderBar $1
echo "= " $2 " ="
repeat
echo ""