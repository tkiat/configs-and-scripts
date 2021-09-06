source ~/.bashrc.shared

. ~/.alias-modules/nix
. ~/.alias-modules/nixos
. ~/.alias-modules/systemctl

alias 2showoff='neofetch && echo "Current firmware ..." && ls /run/current-system/firmware && echo "BIOS ..." && sudo dmesg | grep DMI | grep BIOS'
