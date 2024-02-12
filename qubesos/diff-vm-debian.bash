#!/usr/bin/env bash
# setup debian - run only once
conf="/home/user/configs-and-scripts/configs"

ln -s "$conf/alias/.bash_aliases" ~
ln -s "$conf/bash/.bash_shared" ~
mkdir -p "/home/user/.config/ranger" && ln -s "$conf/ranger/rifle.conf" "/home/user/.config/ranger/rifle.conf"
ln -s "$conf/tmux/.tmux.conf" "/home/user/"

mkdir -p /home/user/mnt/sda && mkdir -p /home/user/mnt/sda1 && mkdir -p /home/user/mnt/sda2 && mkdir -p /home/user/mnt/sdb && mkdir -p /home/user/mnt/sdc

# cp "$conf/xorg/.Xresources" ~ && xrdb -merge /home/user/.Xresources
# mkdir -p "/home/user/.local/share/fonts" && cp "$conf/font/comic-shanns/v2/comic shanns 2.ttf" "/home/user/.local/share/fonts" && fc-cache -v
