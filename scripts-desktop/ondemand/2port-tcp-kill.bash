#!/usr/bin/env bash
if [[ "$#" -eq 0 ]]
then
	echo "argument(s): <port number>"
else
	sudo fuser -k $1/tcp
fi
