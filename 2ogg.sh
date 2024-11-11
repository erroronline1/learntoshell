read -p "enter file name to convert:" filename

ffmpeg -i $filename -c:v libtheora -qscale:v 6 -c:a libvorbis -qscale:a 5 ${filename%.*}.ogv