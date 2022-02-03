#!/usr/bin/env bash
src_dir=~/.mozilla/firefox/6rk7axpn.default/bookmarkbackups
if ! [ -d $src_dir ]; then
  echo "Source folder $src_dir not found. Exiting..."
  exit 1
fi

dest_dir=~/Cloud/Frequent/App/Firefox
if ! [ -d $dest_dir ]; then
  echo "Destination folder $dest_dir not found. Exiting..."
  exit 1
fi

bookmark_arr=( "$src_dir"/*.jsonlz4 )
bookmark_latest="${bookmark_arr[-1]}"
if ! [ -f "$bookmark_latest" ]; then
  echo "Cannot find any Firefox bookmark file inside $src_dir. Exiting..."
  exit 1
fi

rm -f "$dest_dir"/bookmarks-*

# can use e.g. dejsonlz4 later to convert jsonlz4 to json
dest="$dest_dir/bookmarks-$(date +'%Y-%m-%d').jsonlz4"
cp "$bookmark_latest" "$dest"
