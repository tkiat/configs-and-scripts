#!/usr/bin/env python3
import math
import os
import re
import sys

def read_str(prompt):
  return input(prompt)

def read_int(prompt, minimum=-math.inf, maximum=math.inf):
  while True:
    try:
      result = int(input(prompt))
    except ValueError:
      print("Enter an integer!",end=" ")
      continue
    else:
      if minimum <= result <= maximum:
        return result
      else:
        print("Enter integer from " + str(minimum) + " to " + str(maximum) + "!",end=" ")

# insertion order matters here
options, commands = [], []

options += ['Characters -- Remove from index x to y']
commands += ['''
start = read_int("Enter start index: ", minimum=0)
end = read_int("Enter end index: ", minimum=start)
for file in files:
  if file == os.path.basename(__file__):
    continue
  os.rename(file, file[:start] + file[end + 1:])
''']

options += ['Number -- Make first number x digits']
commands += ['''
def prepend_zero_to_int(num, digit):
  return str(10 ** digit + num)[-digit:]
x = read_int("Enter x: ", minimum=0)
for file in files:
  if file == os.path.basename(__file__):
    continue
  last_dot_index = file.rfind('.')
  file_no_ext = file if last_dot_index == -1 else file[0:last_dot_index]
  ext = '' if last_dot_index == -1 else file[last_dot_index:]
  os.rename(file, re.sub('(\d+)', lambda m: prepend_zero_to_int(int(m.group(0)), int(x)), file_no_ext, 1) + ext)
''']

options += ['Number -- Add first number by x']
commands += ['''
x = read_int("Enter x: ")
for file in files:
  if file == os.path.basename(__file__):
    continue
  last_dot_index = file.rfind('.')
  file_no_ext = file if last_dot_index == -1 else file[0:last_dot_index]
  ext = "" if last_dot_index == -1 else file[last_dot_index:]
  os.rename(file, re.sub('(\-?\d+)', lambda m: str(int(m.group(0)) + int(x)), file_no_ext, 1) + ext)
''']

options += ['Text -- Add at specific index']
commands += ['''
index = read_int("Enter Index: ", minimum=0)
text = read_str("Enter Text: ")
for file in files:
  if file == os.path.basename(__file__):
    continue
  os.rename(file, file[0:index] + text + file[index:])
''']

options += ['Word -- Capitalize first letter of each word']
commands += ['''
articles = "a,an,the"
others = "and,of,into,for,with,on,at,from,by,about,as,in,to,like,through,after,over,between,out,against,during,without,before,under,around,among"
exceptions = (articles + "," + others).split(",")
for file in files:
  if file == os.path.basename(__file__):
    continue
  last_dot_index = file.rfind(".")
  file_no_ext = file if last_dot_index == -1 else file[0:last_dot_index]
  ext = "" if last_dot_index == -1 else file[last_dot_index:]
  os.rename(file, re.sub("([a-zA-Z]+)", lambda m: m.group(0) if m.group(0) in exceptions else m.group(0).capitalize(), file_no_ext) + ext)
''']

options += ['Word -- Replace words up to n matches']
commands += ['''
old = read_str("Enter old word: ")
new = read_str("Enter new word: ")
n = read_int("Enter n: ", minimum=0)
for file in files:
  if file == os.path.basename(__file__):
    continue
  os.rename(file, file.replace(old, new, int(n)))
''']

try:
  while True:
    print('----------------------------------------')
    # files = [f for f in os.listdir(os.curdir) if os.path.isfile(f)] if fileOnly else os.listdir(os.curdir)
    files = [f for f in os.listdir(os.curdir) if not f.startswith('.')]
    files = sorted(files)
    for file in files:
      n = 10
      split_strings = [file[index : index + n] for index in range(0, len(file), n)]
      print("|".join(split_strings))
      continue
    print("0123456789|0123456789|0123456789|0123456789 -> Index")
    print('========================================')
    print('         ⭐⭐ Rename Menu ⭐⭐          ')
    print('========================================')
    for index, option in enumerate(options + ["Quit"]):
      print(str(index + 1) + ") " + option)
    choice = read_int(prompt="Please Enter Your Choice: ", minimum=1, maximum=len(options) + 1)
    if 1 <= choice and choice <= len(options):
      exec(commands[choice - 1])
    elif choice == len(options) + 1:
      print("Exiting ...")
      break
    else:
      print("It's impossible to reach here! Check your code!")
except KeyboardInterrupt:
  print("\nExiting ...")
