#!/bin/bash

#read -p "enter folder name to convert:" foldername
if [ "$#" -lt 1 ]
then
    echo "pass folder(s) as parameters"
    exit 1
fi

for foldername in $@; do
    if [ -d "$foldername" ]; then
        for filename in $foldername/*; do
            if [ -f "$filename" ]; then
                #echo "$filename"
                ffmpeg -i $filename -vn -ar 44100 -ac 2 -b:a 192k ${filename%.*}.mp3
            fi
        done    
    else
        echo "$foldername not found"
    fi
done