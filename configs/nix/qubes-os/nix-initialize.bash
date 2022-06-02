#!/usr/bin/env bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. /home/user/.nix-profile/etc/profile.d/nix.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
rm ~/.bashrc ~/.profile
home-manager switch --impure --flake "path:/home/user/configs-and-scripts/configs/nix/qubes-os/${HOSTNAME}#user"
