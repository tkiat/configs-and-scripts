#!/usr/bin/env bash
script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
helper_script=$script_path"/helper"
# insertion order matters here
declare -a options; declare -a commands
options+=('Generate Passphase and copy to clipboard'); commands+=('
read -p "Enter length: " len ;
shuf -n $len /usr/share/dict/words | tr "\n" "." | sed "s/.$//" | xclip -selection clipboard
')
options+=('Generate Password (alphanumeric) and copy to clipboard'); commands+=('
read -p "Enter password length: " len ;
< /dev/urandom tr -cd "A-Za-z0-9" | head -c $len | xclip -selection clipboard
')
options+=('Generate Password (alphanumeric ! @ # % ^ & *) and copy to clipboard'); commands+=('
read -p "Enter password length: " len ;
< /dev/urandom tr -cd "A-Za-z0-9\!\@\#\%^&*" | head -c $len | xclip -selection clipboard
')
options+=('Generate SSH Key Pair'); commands+=('
read -p "Enter filename: " filename ;
read -p "Enter keytype (e.g. rsa, ed25519): " keytype ;
ssh-keygen -f $filename -t $keytype -N ""
')
echo '========================================'
echo '        ⭐⭐Generation Menu ⭐⭐        '
echo '========================================'
PS3='Please enter your choice: '
COLUMNS=1
select opt in "${options[@]}" "Quit"; do
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
