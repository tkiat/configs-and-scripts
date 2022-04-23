pomodoro_bar_i=/tmp/.pomodoro-bar-i
pomodoro_bar_w=/tmp/.pomodoro-bar-w
rm -f $pomodoro_bar_i && mkfifo $pomodoro_bar_i
rm -f $pomodoro_bar_w && mkfifo $pomodoro_bar_w

[ -x "$(command -v chromium)" ] && chromium&
[ -x "$(command -v redshift)" ] && redshift -O 3200
xrdb -merge ~/.Xresources && [ -x "$(command -v xterm)" ] && xterm&

# setxkbmap -layout us,th -option grp:alt_space_toggle
# xsetroot -solid black

exec dbus-launch xmonad
exec xmonad
