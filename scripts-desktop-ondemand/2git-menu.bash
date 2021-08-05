#!/usr/bin/env bash
script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
helper_script=$script_path"/helper"
# insertion order matters here
declare -a options; declare -a commands
options+=('git add -A'); commands+=('git add -A')
options+=('git commit -m <message>'); commands+=('read -p "Enter commit message: " msg; git commit -m "$msg"')
options+=('git push origin $(git rev-parse --abbrev-ref HEAD)'); commands+=('git push origin $(git rev-parse --abbrev-ref HEAD)')
# options+=('git pull origin <current-branch>'); commands+=('git push origin $(git rev-parse --abbrev-ref HEAD)')
options+=('git status'); commands+=('git status')
options+=('git log --graph --decorate --pretty=oneline --abbrev-commit --all'); commands+=('git log --graph --decorate --pretty=oneline --abbrev-commit --all')
options+=('git log --date=iso-strict --pretty=format:"%h %ad %s"'); commands+=('git log --date=iso-strict --pretty=format:"%h %ad %s"')
# options+=('git remote add <alias> <url>'); commands+=('read -p "Hint \"<alias> git@<source>:<username>/<repo>.git\": " repo; git remote add "$repo"')
#options+=('BitBucket API v2'); commands+=('source $helper_script/helper-menu-bitbucketapi_v2.sh')
#options+=('GitHub API v3'); commands+=('source $helper_script/helper-menu-githubapi_v3.sh')
#options+=('GitLab API v4'); commands+=('source $helper_script/helper-menu-gitlabapi_v4.sh')

while true; do
	echo '========================================'
	echo '            ⭐⭐Git Menu ⭐⭐           '
	echo '========================================'
	PS3='Please enter your choice: '
	COLUMNS=1
	select opt in "${options[@]}" "Quit"; do
	echo '----------------------------------------'
		if (( 1<=$REPLY && $REPLY<${#options[@]}+1 )); then
			eval ${commands[$REPLY-1]}
			break
		elif (( $REPLY==${#options[@]}+1 )); then
			break 2
		else
			echo "Invalid Choice!"
			break
		fi
	done
done
