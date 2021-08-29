### common
[ -x "$(command -v redshift)" ] && redshift -O 3000
st&

setxkbmap -layout us,th -option grp:alt_space_toggle
xsetroot -solid black

### xmonad
exec dbus-launch xmonad
exec xmonad

### dwm
# while xsetroot -name " $(date +'%a, %d %b %I:%M:%S%p') "; do
# 	sleep 1
# done &
# exec dwm
