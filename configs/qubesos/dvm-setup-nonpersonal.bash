#!/usr/bin/env bash

sudo dnf config-manager --set-enabled rpmfusion-nonfree
sudo dnf config-manager --set-enabled rpmfusion-nonfree-updates

sudo dnf install qbittorrent unrar
