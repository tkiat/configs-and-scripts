#!/usr/bin/env bash
# insertion order matters here
declare -a options; declare -a commands
options+=('git add -A'); commands+=('git add -A')
options+=('git commit -m <message>'); commands+=('read -p "Enter commit message: " msg; git commit -m "$msg"')
options+=('git push origin $(git rev-parse --abbrev-ref HEAD)'); commands+=('git push origin $(git rev-parse --abbrev-ref HEAD)')
# options+=('git pull origin <current-branch>'); commands+=('git push origin $(git rev-parse --abbrev-ref HEAD)')
options+=('git status'); commands+=('git status')
options+=('git log --graph --decorate --pretty=oneline --abbrev-commit --all'); commands+=('git log --graph --decorate --pretty=oneline --abbrev-commit --all')
options+=('git log --date=iso-strict --pretty=format:"%h %ad %s"'); commands+=('git log --date=iso-strict --pretty=format:"%h %ad %s"')

while true; do
	echo '========================================'
	echo '            ⭐⭐Git Menu ⭐⭐           '
	echo '========================================'
	PS3='Please enter your choice: '
	COLUMNS=1
	select opt in "${options[@]}" "Quit"; do
	echo '----------------------------------------'
		if (( 1<=$REPLY && $REPLY<${#options[@]}+1 )); then
			eval "${commands[$REPLY-1]}"
			break
		elif (( $REPLY==${#options[@]}+1 )); then
			break 2
		else
			echo "Invalid Choice!"
			break
		fi
	done
done
