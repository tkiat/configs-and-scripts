#!/usr/bin/env bash

# https://unix.stackexchange.com/questions/519887/batch-download-a-series-of-files-and-add-prefix-to-them

prefix=1

for i in "$@"
do
  filename="$(printf "%03d" $prefix)_${i##*/}"
  wget "$i" -O "$filename"
  prefix=$((prefix+1))
done
