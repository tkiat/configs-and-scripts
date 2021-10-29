#!/usr/bin/env python3
import sys
from typing import List

def get_command(args: List[str], obj: dict) -> str:
    if args and args[0] in obj:
        new = obj[args[0]]
        return new if isinstance(new, str) else get_command(args[1:], new)
    else:
        return ""

i = {
    'root': 'echo root',
    'user': 'echo user',
}
opt={
    'i': i
}

cmd=get_command(sys.argv[1:], opt)
print(cmd)
