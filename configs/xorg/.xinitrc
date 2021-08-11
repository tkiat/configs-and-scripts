### common

# [ -x "$(command -v xrandr)" ] && xrandr --output LVDS-1 --brightness 0.9
[ -x "$(command -v redshift)" ] && redshift -O 3000

setxkbmap -layout us,th -option grp:alt_space_toggle
xsetroot -solid black

# chromium&
# st&
source ~/.xinitrc.shared

### xmonad

exec dbus-launch xmonad
exec xmonad

### dwm

# while xsetroot -name " $(date +'%a, %d %b %I:%M:%S%p') "; do
# 	sleep 1
# done &
# exec dwm
