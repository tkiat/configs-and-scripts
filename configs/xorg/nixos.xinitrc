# pomodoro-px
pomodoro_px_rpipe=/tmp/.pomodoro-px-resting
pomodoro_px_wpipe=/tmp/.pomodoro-px-working
rm -f $pomodoro_px_rpipe && mkfifo $pomodoro_px_rpipe
rm -f $pomodoro_px_wpipe && mkfifo $pomodoro_px_wpipe

chromium&

. ~/.xinitrc.shared
