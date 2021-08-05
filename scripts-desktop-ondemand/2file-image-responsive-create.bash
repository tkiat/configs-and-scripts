#!/usr/bin/env bash
filename_and_ext="${1##*/}"
filename="${filename_and_ext%%.*}"
ext="${filename_and_ext#*.}"

read w h <<< $(identify -format '%w %h' "$1")
if [ $2 -ne "0" ] && [ $(($w % $2)) -eq "0" ] && [ $(($h % $2)) -eq "0" ]; then
	let stepW=$(($w / $2))
	let stepH=$(($h / $2))
	let cur=1
	for i in $(seq 1 $2); do
		convert "$1" -resize $(($stepW * $i))x$(($stepH * $i)) "$filename-$(($stepW * $i))x$(($stepH * $i)).${ext}"
	done
	# display img tag
# 	IFS=/
# 	read -ra val <<< $(pwd)
# 	article_dir="${val[*]:(-4)}"
# 	IFS=$'\n'
	source="{img-url}" # AsciiDoctor's variables
	srcset=""
	for i in $(seq 1 $2); do
		srcset="$srcset
$source/$filename-$(($stepW * $i))x$(($stepH * $i)).$ext $(($stepW * $i))w"
		if [ $i -ne $2 ]; then
			srcset="$srcset,"
		else
			srcset="$srcset\"";
		fi
	done
	cat<<-EOF
	<img srcset="$srcset
		sizes="(max-width: $(($w + 100))px) 70vw,
		${w}px"
		src="${source}/${filename}-${w}x${h}.${ext}"
		alt="&lt;img2&gt;">
	EOF
else
	echo "cannot resize image: width ($w px) or height ($h px) are not divisible by $2"
	echo "Usage: <this command> <file name> <number of division you want>"
fi
