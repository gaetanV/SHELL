#!/bin/sh

#SET YOUR TEMP DIRECTORY
TMP='./tmp/'
if [ ! -d "$TMP" ]; then mkdir TMP; fi

#SET YOUR ARGS
if [ -z "$1" ]; then echo "you need to give the file path" ; exit ; fi
if [ -z "$2" ]; then echo "you need to give the number of cut" ; exit ; fi

#CHECK
if [ ! -e "$1" ]; then echo "error file not exist" ; exit ; fi
MIME=$(sudo file "$1" --mime-type -b) 

#SET EXTENSION
EXT=""
case $MIME in
    "image/jpeg")
        EXT="jpg"
        ;;
    *)
        echo  "type $MIME is not yet supported" 
        exit
esac

#SET GRID X*Y
X=$2
Y=$X
if [ ! -z "$3" ] ; then Y=$3 ; fi

#SET THE SIZE 
WIDTH=$(($(identify -format '%w' $1)/$X))
HEIGHT=$(($(identify -format '%h' $1)/$Y))

#DISPLAY

echo "GRID ${X}x${Y}"
echo "$(($X*$Y)) PICTURES ${WIDTH}x${HEIGHT}"
CMP=0
for i in $(seq 0 $(($X-1))); do
    for j in $(seq 0 $(($Y-1))); do
           NAME="${TMP}/${i}_${j}.${EXT}"
           convert -crop "${WIDTH}x${HEIGHT}+$((WIDTH*i))+$((HEIGHT*j))" $1 $NAME
           CMP=$(($CMP+1));
           printf  '.'
           if [ $(($CMP%$X)) = 0 ] ; then  printf '\n'; fi
    done
done

echo "done"