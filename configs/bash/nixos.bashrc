source ~/.bashrc.shared

. ~/.alias/modules/nix.alias
. ~/.alias/modules/nixos.alias
. ~/.alias/modules/systemctl.alias

alias 2showoff='neofetch && echo "ls /run/current-system/firmware" && ls /run/current-system/firmware && sudo dmidecode -t bios -q | head -n 2'
