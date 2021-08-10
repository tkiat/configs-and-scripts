#!/run/current-system/profile/bin/bash
loadkeys en # set keyboard layout
# wireless
rfkill unblock all
dev=$(iw dev | awk '$1=="Interface"{print $2}')
echo "list of available wifis:"
iw dev $dev scan | grep SSID
echo "Type wifi ssid"
read ssid
echo "Type wifi password"
read -s password
cat << EOF > wireless.conf
network={
  ssid="$ssid"
  key_mgmt=WPA-PSK
  psk="$password"
}
EOF
wpa_supplicant -c wireless.conf -i $dev -B
dhclient -v $dev
