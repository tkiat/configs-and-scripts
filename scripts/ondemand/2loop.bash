#!/usr/bin/env bash
items=$(seq -w 1 12)


for i in $items
do
  mkdir "hw$i"
done

# fd --extension md --print0 |
#     while IFS= read -r -d '' line; do 
#         wc -m "$line"
#     done
