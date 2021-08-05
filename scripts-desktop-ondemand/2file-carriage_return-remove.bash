#!/usr/bin/env bash
if [ $# -eq 0 ]; then 
	echo 'argument(s): <filename>'
else 
	sed -i 's/\r$//g' $1
fi
