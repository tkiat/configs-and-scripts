#!/usr/bin/env bash
sudo dnf remove vim

# RPM fusion for QubesOS
sudo dnf config-manager --set-enabled rpmfusion-free
sudo dnf config-manager --set-enabled rpmfusion-free-updates
sudo dnf config-manager --set-enabled rpmfusion-nonfree
sudo dnf config-manager --set-enabled rpmfusion-nonfree-updates
sudo dnf upgrade --refresh

sudo dnf install\
 bat\
 chromium\
 exa\
 git\
 google-noto-sans-thai-fonts.noarch
 libreoffice\
 mc\
 mpv
 mupdf\
 neovim\
 newsboat\
 okular\
 ranger
 ripgrep\
 qview\
 simplescreenrecorder\
 telegram-desktop
 weechat\
 xclip

# nonfree
sudo dnf install qbittorrent unrar
