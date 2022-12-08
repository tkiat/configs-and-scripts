#!/usr/bin/env bash
# setup fedora - run only once
conf="/home/user/configs-and-scripts/configs"
cp "$conf/xorg/.Xresources" ~ && xrdb -merge /home/user/.Xresources
mkdir -p "/home/user/.local/share/fonts/comic shanns 2" && cp "$conf/font/comic-shanns/v2/comic shanns 2.ttf" "/home/user/.local/share/fonts/comic shanns 2" && fc-cache -v

cp "$conf/alias/shared.alias" "/home/user/.shared.alias"
cp "$conf/bash/.bashrc.shared" ~
cp "$conf/ranger/rifle.conf" "/home/user/.config/ranger/rifle.conf"

mkdir -p /home/user/mnt/sda && mkdir /home/user/mnt/sda1 && mkdir /home/user/mnt/sda2 && mkdir /home/user/mnt/sdb && mkdir /home/user/mnt/sdc