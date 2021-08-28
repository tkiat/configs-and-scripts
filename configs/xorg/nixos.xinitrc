chromium&

xpomodoro_resting=/tmp/.xpomodoro-resting
xpomodoro_working=/tmp/.xpomodoro-working
rm -f $xpomodoro_resting && mkfifo $xpomodoro_resting
rm -f $xpomodoro_working && mkfifo $xpomodoro_working

. ~/.xinitrc.shared
