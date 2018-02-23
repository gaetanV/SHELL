#!/bin/bash

#SET YOUR ARGS
if [ -z "$1" ]; then echo "you need to give you file" ; exit ; fi

#CHECK
if [ ! -f "$1" ]; then echo "$1 is a not a file" ; exit ; fi

FNAME=$1

#MIME
declare -A EXT
EXT["sh"]="text/x-shellscript"
EXT["go"]="text/x-c";

MI="UNKNOWN"
r=${FNAME##*.}
if [[ "$r" != "" && ${#r} > 1 && "$r" != "$FNAME" ]]; then 
    if [[ -n "${EXT["$r"]}" ]]; then  MI=${EXT[$r]}; fi
fi

MIME=$(file $FNAME --mime-type -b) 

if [ $MI != $MIME ] ; then
    echo "$FNAME error mime $MIME"
    exit
else 
    echo "$FNAME ok"
fi