# pomodoro-px
pomodoro_px_rpipe=/tmp/.pomodoro-px-resting
pomodoro_px_wpipe=/tmp/.pomodoro-px-working
rm -f $pomodoro_px_rpipe && mkfifo $pomodoro_px_rpipe
rm -f $pomodoro_px_wpipe && mkfifo $pomodoro_px_wpipe

[ -x "$(command -v chromium)" ] && chromium&
[ -x "$(command -v redshift)" ] && redshift -O 3000
[ -x "$(command -v xterm)" ] && xterm&
[ -x "$(command -v ungoogled-chromium)" ] && ungoogled-chromium --incognito --disable-default-check&

xrdb -merge ~/.Xresources

setxkbmap -layout us,th -option grp:alt_space_toggle
xsetroot -solid black

### sway
# exec sway

### xmonad
exec dbus-launch xmonad
exec xmonad

### dwm
# while xsetroot -name " $(date +'%a, %d %b %I:%M:%S%p') "; do
# 	sleep 1
# done &
# exec dwm
