#!/run/current-system/profile/bin/bash
modprobe dm_mod # load device mapper module in current kernel
lsblk
echo "Partitioning /dev/sdx, enter x"
read x
echo "make it gpt"

parted --align optimal /dev/sd${x} <<EOF
mklabel GPT
Yes
q
mkpart primary 0% 100%
EOF

cryptsetup -v --cipher serpent-xts-plain64 --key-size 512 --hash whirlpool --iter-time 500 --use-random --verify-passphrase luksFormat /dev/sd${x}1
luksUUID=$(cryptsetup luksUUID /dev/sd${x}1)
cryptsetup luksOpen /dev/sd${x}1 temp
mkfs.btrfs -L guix /dev/mapper/temp
mount LABEL=guix /mnt

# swap file
touch /mnt/swapfile
chattr +C /mnt/swapfile
guix install btrfs-progs
btrfs property set /mnt/swapfile compression none
dd if=/dev/zero of=/mnt/swapfile bs=1MiB count=4096
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile
