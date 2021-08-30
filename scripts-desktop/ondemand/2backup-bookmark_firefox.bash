#!/usr/bin/env bash
src_dir=~/.mozilla/firefox/9ivxo1xk.default-default/bookmarkbackups
if ! [ -d $src_dir ]; then
  echo "Source folder $src_dir not found. Exiting..."
  exit 1
fi

dest_dir=~/Sync/Personal-Cloud/App/Firefox
if ! [ -d $dest_dir ]; then
  echo "Destination folder $dest_dir not found. Exiting..."
  exit 1
fi

bookmark_arr=( "$src_dir/*.jsonlz4" )
bookmark_latest="${bookmark_arr[-1]}"
if ! [ -f "$bookmark_latest" ]; then
  echo "Cannot find any Firefox bookmark file inside $src_dir. Exiting..."
  exit 1
fi

rm -f "$dest_dir/bookmark-Firefox-*"

# can use e.g. dejsonlz4 later to convert jsonlz4 to json
src="$HOME/.mozilla/firefox/9ivxo1xk.default-default/bookmarkbackups/$bookmark_latest"
dest="$dest_dir/bookmark-Firefox-$(date +'%Y_%m_%d').jsonlz4"
cp "$src" "$dest"
