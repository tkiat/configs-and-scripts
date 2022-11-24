#!/usr/bin/env bash
# setup fedora - run only once
conf="/home/user/configs-and-scripts/configs"
cp "$conf/xorg/.Xresources" ~ && xrdb -merge /home/user/.Xresources
mkdir -p "/home/user/.local/share/fonts/comic shanns 2" && cp "$conf/font/comic-shanns/v2/comic shanns 2.ttf" "/home/user/.local/share/fonts/comic shanns 2" && fc-cache -v
cp "$conf/qubesos/nonpersonal-dvm.alias" ~

cp "$conf/ranger/rifle.conf-nonpersonal_dvm" "/home/user/.config/ranger/rifle.conf"
