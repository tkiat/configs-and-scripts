#!/usr/bin/env bash
sudo dnf install\
 bat\
 chromium\
 dust\
 exa\
 git\
 libreoffice\
 mc\
 neovim\
 newsboat\
 ranger
 rg\
 qview\
 weechat

sudo dnf remove vim

# RPM fusion for QubesOS
sudo dnf config-manager --set-enabled rpmfusion-free
sudo dnf config-manager --set-enabled rpmfusion-free-updates
# sudo dnf config-manager --set-enabled rpmfusion-nonfree
# sudo dnf config-manager --set-enabled rpmfusion-nonfree-updates
sudo dnf upgrade --refresh

sudo dnf install\
 simplescreenrecorder\
 mpv
