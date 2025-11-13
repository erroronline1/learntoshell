#!/bin/bash

#read -p "enter file name to convert:" filename
if [ "$#" -lt 1 ]
then
    echo "pass filenames with extension as parameters or continue to convert all found video files of formats mp4, avi and mts"
    read -p "[c]ontinue / [A]bort:" choice
    if [ "${choice^^}" == "C" ]
    then
        shopt -s nocaseglob
        filenames=$(ls *.mp4 *.avi *.mts)
        shopt -u nocaseglob
    else
        exit 1
    fi
else filenames=$@
fi

for filename in $filenames
do
    if [ -f "$filename" ]
    then
    echo "converting $filename"
    ffmpeg -i $filename -c:v libtheora -qscale:v 6 -c:a libvorbis -qscale:a 5 ${filename%.*}.ogv
    else
    echo "$filename not found"
    fi
done