#!/usr/bin/env python3

# usage
# data='{ "i": { "root": "echo root", "user": "echo user" } }'
# echo $(python3 ~/configs-and-scripts/scripts/ondemand/helper/get_json_leaf.py "$data" "$1" "$2")

import json
from sys import argv
from typing import List

def get_command(args: List[str], obj: dict) -> str:
    if args and args[0] in obj:
        new = obj[args[0]]
        return new if isinstance(new, str) else get_command(args[1:], new)
    else:
        return ""

data=json.loads(argv[1])
args=argv[2:]

print(get_command(args, data))
