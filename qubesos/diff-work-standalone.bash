#!/usr/bin/env bash
# --- debian
sudo apt install\
  exa\
  feh\
  ranger
# --- nix
if ! [ -f "/home/$USER/.nix-profile/etc/profile.d/nix.sh" ]; then
  echo installing nix ...
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi
# --- flatpak
if ! [ -x "$(command -v flatpak)" ]; then
  echo installing flatpak ... && sudo apt install flatpak

  echo add flatpak remotes ...
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  echo installing flatpak packages ...
  flatpak install --assumeyes flathub org.gimp.GIMP
  flatpak install --assumeyes flathub io.neovim.nvim && ln -v -s "/home/$USER/configs-and-scripts/config/nvim" "/home/$USER/.var/app/io.neovim.nvim/config"
fi
