#!/usr/bin/env bash
TOFORMAT=jpg
for filename in $@
do
	# ext=$(echo $filename | awk 'BEGIN { FS = "." } ; {print $(NF)}')
	name=$(echo $filename | cut -d '.' -f 1)

	case $TOFORMAT in
		ogg)
			ffmpeg -i $filename -b:a 192k "$name.ogg"
			;;

		jpg)
			mogrify -format jpg $filename
			;;

		*)
			echo -n "Unknown Format"
			;;
	esac
done
