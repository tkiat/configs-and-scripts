#!/usr/bin/env bash
echo "passwd root"
passwd
echo "passwd user tkiat"
passwd tkiat

guix pull
export PATH="$HOME/.config/guix/current/bin:$PATH"
export INFOPATH="$HOME/.config/guix/current/share/info:$INFOPATH"
echo "now please reboot the device"
