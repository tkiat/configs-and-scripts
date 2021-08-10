#!/usr/bin/env bash
# This script assumes you already have full-disk encrypted disk with luks and then install lvm on top of that
# variables ----------------------------------------
disk=/dev/sdb
disk_part=/dev/sdb1
overwrite_disk=true # true or false

lv_name=void_glibc
lv_size=10G
vg_name=intenso120gb
filesystem=xfs

filepath=~/Downloads/void-x86_64-ROOTFS-20191109.tar.xz
url_fallback="https://alpha.de.repo.voidlinux.org/live/current/void-x86_64-ROOTFS-20191109.tar.xz"

mnt_dir="/mnt/$(echo $lv_name | sed 's/_/-/g')"
# installation -------------------------------------
echo -ne "\nEnter disk encryption password: " && read -s encrypt_pwd
# wipe disk and create 1 primary partition then encrypt it
if [ "$overwrite_disk" = true ]; then
	sudo dd if=/dev/zero of=$disk bs=8M count=4
	echo 'type=83' | sudo sfdisk $disk
	echo -e "$encrypt_pwd\n$encrypt_pwd" | sudo cryptsetup luksFormat --batch-mode --type luks1 $disk_part
	echo "$encrypt_pwd" | sudo cryptsetup luksOpen $disk_part $vg_name
	sudo vgcreate $vg_name /dev/mapper/$vg_name
fi

# create logical volume
sudo lvcreate --name $lv_name -L $lv_size $vg_name
eval sudo "mkfs.$filesystem" -L $lv_name "/dev/$vg_name/$lv_name"

# mount it
sudo mkdir -p $mnt_dir
sudo mount "/dev/$vg_name/$lv_name" $mnt_dir

# copy files to the mountpoint
if [ -f "$filepath" ]; then
	sudo tar xf $filepath -C $mnt_dir
else
	filename=$(echo $url_fallback | awk -F/ '{print $NF}')
	if [ ! -f "$filename" ]; then
		curl -O $url_fallback
	fi
	sudo tar xf $filename -C $mnt_dir
fi
# volume.key
if [ "$overwrite_disk" = true ]; then
	sudo dd bs=1 count=64 if=/dev/urandom of=$mnt_dir/boot/volume.key
	echo -e "$encrypt_pwd\n$encrypt_pwd" | sudo cryptsetup luksAddKey --batch-mode $disk_part $mnt_dir/boot/volume.key
	sudo chmod 000 $mnt_dir/boot/volume.key
	sudo chmod -R g-rwx,o-rwx $mnt_dir/boot
else
	sudo cp /boot/volume.key $mnt_dir/boot
fi

# bind mount
for dir in dev proc run sys; do
	sudo mkdir -p $mnt_dir/$dir
	sudo mount --rbind /$dir $mnt_dir/$dir
	sudo mount --make-rslave $mnt_dir/$dir
done

sudo -v
# perform installation
echo "chrooting..."
sudo chroot "$mnt_dir" /bin/bash <<EOF
echo 'nameserver 192.168.43.1' >> /etc/resolv.conf

xbps-install -Suy xbps
xbps-install -uy
xbps-install -y base-system lvm2 cryptsetup grub
xbps-remove base-voidstrap

chown root:root /
chmod 755 /
xbps-reconfigure -f glibc-locales

echo "# <file system>             <dir> <type>      <options>             <dump>  <pass>" >  /etc/fstab
echo "tmpfs                       /tmp  tmpfs       defaults,nosuid,nodev 0       0"      >> /etc/fstab
echo "/dev/$vg_name/$lv_name      /     $filesystem defaults              0       0"      >> /etc/fstab

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& rd.lvm.vg=$vg_name rd.luks.uuid=$(lsblk -o uuid $disk_part | sed -n 2p)/' /etc/default/grub
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub

mkdir -p /boot/grub && update-grub
EOF

if [ "$overwrite_disk" = true ]; then
	echo "chrooting..."
	sudo chroot "$mnt_dir" /bin/bash <<-EOF
	grub-install $disk
	EOF
else
	echo "update host os grub entry..."
	sudo update-grub
fi

echo "chrooting..."
sudo chroot "$mnt_dir" /bin/bash <<-EOF
xbps-reconfigure -fa
EOF

# perform post-installation
echo -n "Enter root password for a new os: " && read -s root_pwd
echo -ne "\nCreating a non-privileged user. Enter username: " && read user_name
echo -n "Enter his/her password: " && read -s user_pwd

echo -ne "\nEnter WiFi SSID: " && read wifi_ssid
echo -n "Enter WiFi Password: " && read -s wifi_pwd

hostname=$(echo $lv_name | sed 's/_/-/g')
# chroot and configure
echo "chrooting ..."
sudo chroot "$mnt_dir" /bin/bash <<EOF
echo "adding root password ..."
echo -e "$root_pwd\n$root_pwd" | passwd root

echo '%wheel ALL=(ALL) ALL' | sudo EDITOR='tee -a' visudo
echo "adding $user_name ..."
useradd -m -U -G wheel,users,audio,video,cdrom,input $user_name
echo "adding $user_name password ..."
echo -e "$user_pwd\n$user_pwd" | passwd $user_name

echo "adding hostname ..."
echo $hostname > /etc/hostname

echo "$vg_name   UUID=$(lsblk -o uuid $disk_part | sed -n 2p)   /boot/volume.key   luks" >> /etc/crypttab
echo "install_items+=\" /boot/volume.key /etc/crypttab \"" > /etc/dracut.conf.d/10-crypt.conf

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales
sudo ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

echo "generate WPA-PSK credential ..."
echo ctrl_interface=/var/run/wpa_supplicant > /etc/wpa_supplicant/wpa_supplicant.conf
echo update_config=1 >> /etc/wpa_supplicant/wpa_supplicant.conf
echo eapol_version=1 >> /etc/wpa_supplicant/wpa_supplicant.conf
echo ap_scan=1 >> /etc/wpa_supplicant/wpa_supplicant.conf
echo fast_reauth=1 >> /etc/wpa_supplicant/wpa_supplicant.conf
wpa_passphrase $wifi_ssid $wifi_pwd >> /etc/wpa_supplicant/wpa_supplicant.conf
sudo ln -s /etc/sv/wpa_supplicant /var/service/wpa_supplicant

echo "configure dhcp"
sudo xbps-install -y dhcpcd
sudo ln -s /etc/sv/dhcpcd /var/service/dhcpcd
sleep 5
echo 'nameserver 192.168.43.1' >> /etc/resolv.conf
EOF
