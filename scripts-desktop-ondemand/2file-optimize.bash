#!/usr/bin/env bash
for filename in "$@"
do
	# epub
	if [[ $filename =~ .*\.(epub|cbz) ]]
	then
		echo "optimizing $filename ..."
		tempdir=$(mktemp -d)
		unzip -q "$filename" -d "$tempdir"
		cd "$tempdir" || exit
		for subfilename in $(find .)
		do
			if [[ $subfilename =~ .*\.(png) ]]
			then
				echo "optimizing $subfilename ..."
				pngquant -f --quality 0-10 "$subfilename" --output "$subfilename"
			fi
			if [[ $subfilename =~ .*\.(jpg|jpeg) ]]
			then
				echo "optimizing $subfilename ..."
				jpegoptim --size=150k -q "$subfilename"
			fi
		done

		zip "$filename" -r ./*
		cd - || exit
		mv "$tempdir"/"$filename" .
		rm -rf "$tempdir"
	fi

	# jpg
	if [[ $filename =~ .*\.(jpg|jpeg) ]]
	then
		echo "optimizing $filename ..."
		jpegoptim --size=150k -q "$filename"
	fi

	# video
	if [[ $filename =~ .*\.(avi|mp4|mov|mpg) ]]
	then
		echo "optimizing $filename ..."
		tempname=$(mktemp --suffix ".${filename##*.}")
		rm "$tempname"
		ffmpeg -i "$filename" -crf 30 "$tempname" && mv "$tempname" "$filename"
	fi

	# pdf
	if [[ $filename =~ .*\.pdf ]]
	then
		echo "optimizing $filename ..."
		tempfile=$(mktemp)
		gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$tempfile" "$filename" && mv "$tempfile" "$filename"
	fi

	# png
	if [[ $filename =~ .*\.png ]]
	then
		echo "optimizing $filename ..."
		pngquant -f --quality 0-10 "$filename" --output "$filename"
	fi
done

# shopt -s nullglob
# for filename in *.png *.jpg *.jpeg
# # for i in {0..6}
# # convert $filename -strip -interlace Plane -gaussian-blur 0.05 -quality 5% temp && mv temp $filename
# # ffmpeg -i $filename -crf 30 "temp$filename" && mv "temp$filename" $filename
# # gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=temp $filename && mv temp $filename
