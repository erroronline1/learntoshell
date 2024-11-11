#!/bin/bash

#read -p "enter file name to convert:" filename
if [ "$#" -lt 1 ]
then
    echo "pass filenames with extension as parameters"
    exit 1
fi

for filename in $@
do
    if [ -f "$filename" ]
    then
    ffmpeg -i $filename -c:v libtheora -qscale:v 6 -c:a libvorbis -qscale:a 5 ${filename%.*}.ogv
    else
    echo "$filename not found"
    fi
done