#!/usr/bin/env bash
# items=$(seq -w 1 12)


for i in $(ls)
do
  echo -n "$i - " && mediainfo --Inform="Video;%Duration/String%" $i
done

# fd --extension md --print0 |
#     while IFS= read -r -d '' line; do 
#         wc -m "$line"
#     done
