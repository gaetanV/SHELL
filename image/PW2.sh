#!/bin/sh

#SET YOUR ARGS
if [ -z "$1" ]; then echo "you need to give the file path" ; exit ; fi

#CHECK
if [ ! -e "$1" ]; then echo "error file not exist" ; exit ; fi

WIDTH=$(identify -format '%w' $1)
HEIGHT=$(identify -format '%h' $1)

WIDTH_2=$WIDTH;
HEIGHT_2=$HEIGHT;

echo "Aalyse File $WIDTH x $HEIGHT"

powerof2() {
    A=$(($1 % 2))
    B=$(($1 - $A))
    echo $B
}

ispowerOf2() {
    A=$(($1 % 2))
    if [ "$A" != "0" ] || [ "$1" -eq "0" ]; then
        echo 0
    else
        echo 1
    fi
}

if [ $(ispowerOf2 $WIDTH) != 1 ]; then
    echo "ERROR $WIDTH is not a power of 2"
    WIDTH_2=$(powerof2 $WIDTH)
fi

if [ $(ispowerOf2 $HEIGHT) != 1 ]; then
    echo "ERROR $HEIGHT is not a power of 2"
    HEIGHT_2=$(powerof2 $HEIGHT)
fi

echo "New format File $WIDTH_2 x $HEIGHT_2"