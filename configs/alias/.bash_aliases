# All are bash compatible (to test: shellcheck --shell bash <thisfile>)

# catch typo
alias dc='cd'
alias ceho='echo'
alias ehco='echo'
alias gf='fg'
alias sl='ls'
alias nv="nvim"
alias ivm='vim'

# common
alias 2less="bat --pager=less"

# overwrite default
alias alacritty="LIBGL_ALWAYS_SOFTWARE=1 alacritty"
alias cal="cal -3"
# alias cmus="cd ~/Sync/Public/Music/ && cmus && cd -"
alias coolreader="cr3"
alias cp="cp --preserve=all"
alias df="df -h"
      dict() {
        command dict "$1" | 2less
      }
alias du="du --max-depth=1 -k | sort -n | cut -f2 | xargs -d '\n' du -sh"
# alias dust="dust --depth 1"
# alias exa="exa --group-directories-first"
alias feh="feh --scale-down --auto-zoom"
alias fgrep='fgrep --color=auto'
alias free="free -h"
alias freefilesync="/opt/FreeFileSync/FreeFileSync"
alias grep='grep --color=auto'
alias less='less -r'
alias ls="exa -g"
# alias mupdf='mupdf -C aaaaaa -I'
alias polybar='polybar xmonad --config-file=~/.config/polybar/config.ini'
      pomodoro-bar-notify() {
        local cmdwork='notify-send "pomodoro-bar" "<span color=\"yellow\" background=\"blue\" font=\"100px\"><b>PAUSE</b></span>"'
        local cmdwork='notify-send "pomodoro-bar" "<span color=\"green\" background=\"red\" font=\"100px\"><b>RESUME</b></span>"'
        command pomodoro-bar -w 50 -b 15 -l 60 --cmdwork "$cmdwork" --cmdbreak "$cmdbreak" "$@"
      }
alias pomodoro-bar-xset="pomodoro-bar -w 50 -b 15 -l 60 --cmdwork 'xset dpms force off' --cmdbreak 'xset dpms force off' --bartype xmobar"
alias pomodoro-bar-py-xset="pomodoro-bar-py -w 50 -b 15 -l 60 --cmdwork 'xset dpms force off' --cmdbreak 'xset dpms force off' --bartype xmobar"
alias python="python3"
alias qutebrowser="qutebrowser --target private-window"
alias ranger="ranger"
alias rg="rg --ignore-case"
alias sudo='sudo ' # enable running alias as superuser$
alias telegram-cli="telegram-cli --enable-msg-id --wait-dialog-list"
alias tokei="tokei --sort code"
alias tree="exa -T"
alias xpdf="xpdf -z width"

# new commands
alias ..='cd ..'
alias ...='cd ../..'
alias 2a="alias"
alias 2bios-ver="sudo dmidecode | grep 'BIOS Information' -A 2"
alias 2brightness-change="[ -x '$(command -v xrandr)' ] && xrandr --output LVDS-1 --brightness"
alias 2chown-u="sudo chown 1000:1000 -R"
alias 2clipboard-get="xclip -o -selection clipboard"
alias 2clipboard-set="tr -d '\n' | xclip -selection clipboard" # usage: pwd | 2clipboard-set
alias 2clipboard-set_withnewline="xclip -selection clipboard"
      2convert-dot-svg() {
        for i in "$@"
        do
          if [ "${i: -4}" == ".dot" ]; then
            echo "dot -Tsvg $i > ${i%.*}.svg"
            dot -Tsvg "$i" > "${i%.*}.svg"
          fi;
        done
      }
alias 2convert-jpgs_pdfs="mogrify -format pdf *.jpg"
      2convert-raw() {
        for i in "$@"
        do
          dcraw -c -w "$i" | convert - "${i%\.*}.jpg"
        done
      }
alias 2cookiecutter-hint="echo cookiecutter gh:tkiat/templates --directory='hs-nix'"
alias 2cpu-setfreq-ondemand="for i in {0..$(($(nproc)-1))}; do sudo cpufreq-set -c \$i -g ondemand; done"
      2create-cbz() {
       zip ../${PWD##*/}.cbz *
      }
alias 2diff-folders="diff -x '.*' -rq"
alias 2dropbox-headless="~/.dropbox-dist/dropboxd & disown"
alias 2e=2edit
      2edit() {
        local arg=${1:-.}
        local f=
        case "$arg" in
          .) f=. ;;
          alias) f=~/configs-and-scripts/configs/alias ;;
          config) f=~/configs-and-scripts/configs ;;
          neovim) f=~/configs-and-scripts/configs/neovim ;;
          nixos) f=~/configs-and-scripts/configs/nixos ;;
          nvim) f=~/configs-and-scripts/configs/neovim ;;
          polybar) f=~/.config/polybar/config.ini ;;
          pomodoro) f=~/.local/share/pomodoro-bar/record.json ;;
          script) f=~/configs-and-scripts/scripts ;;
          xmobar) f=~/configs-and-scripts/configs/xmobar/.xmobarrc ;;
          xmonad) f=~/configs-and-scripts/configs/xmonad/xmonad.hs ;;
          *)
            if [ -f "$(command -v $arg)" ]; then
              f="$(command -v "$arg")"
            elif [ -f "$arg" ]; then
              f=$arg
            fi;
        esac

        if [ -n "$f" ]; then
          echo $EDITOR $f
          $EDITOR "$f"
        else echo unknown arguments
        fi;
      }
      2file-name2date() {
        [ -d "name2date" ] && echo "directory \"name2date\" already exists. remove it first" && return
        [ -d "name2date-unmodified" ] && echo "directory \"name2date-unmodified\" already exists. remove it first" && return
        mkdir name2date && mkdir "name2date-unmodified"
        for filename in "$@"
        do
          newname=$(exiftool -d "%Y_%m_%d-%H%M%S" -DateTimeOriginal -short -veryShort "$filename")
          if [ -z "$newname" ]
          then
            cp --preserve=all "$filename" "name2date-unmodified/$filename"
          else
            cp --preserve=all "$filename" "name2date/$newname"."$(echo "$filename" | cut -d '.' -f 2)"
          fi
        done
      }
alias 2file-size="du -a --max-depth=1 --si | awk -F' ' '{ if (\$2 != \".\") {print} }' | sort -h && echo "" && echo This is SI format"
alias 2git-addconfig='git config --local include.path ../.gitconfig'
      2git-display-folders-not-update() { for x in $(\ls -d */); do cd $x; git fetch -q 1>/dev/null; [ "$(git rev-parse HEAD 2>/dev/null)" != "$(git rev-parse @{u} 2>/dev/null)" ] && echo $x; cd ..; done; }
alias 2git-push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias 2git-remote='git remote -v'
      2git-show-template() {
        echo "GitHub SSH: git@github.com:tkiat/repository-name.git"
        echo "GitLab SSH: git@gitlab.com:tkiat/repository-name.git"
      }
alias 2git-sort-size="git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | cut -c 1-12,41- | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=neares"
      2git-update() {
        git add -A && git commit -m "${1:-UPDATE}" && git push origin "$(git rev-parse --abbrev-ref HEAD)"
      }
      2goto-symlink() { cd $(dirname $(readlink $1)); }
alias 2gpg-edit='gpg --edit-key tkiat@tutanota.com'
      2gpg-encrypt-for-me() {
        for i in "$@"
        do
          gpg --output "$i".gpg --encrypt --cipher-algo AES256 --recipient theerawat@kiatdarakun.com "$i"
        done
      }
alias 2grep-current-dir="grep -inr . -e "
      2grep-markdown-width() { rg --line-number '.' | sed -E 's/\[([^]]*)\]\([^\)]*\)/\1/g; s/<[^>]*>//g; s/^([^:]*:[^:]*:)\s+(.*)/\1\2/g' | rg "(.*?):(.*?):.{${1:-500},}" -r 'filename: $1, line number: $2'; }
alias 2grub-make="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias 2join-pdf="gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=joined.pdf *.pdf"
alias 2keyring-get-gnu="wget https://ftp.gnu.org/gnu/gnu-keyring.gpg"
alias 2logout="pkill -u $USER"
      2loop-heic-to-jpg() {
        for i in "$@"
        do
          if [ "${i: -5}" == ".heic" ]; then
              noext=$(echo "$i" | cut -d '.' -f 1)
              heif-convert -q 100 "$i" "$noext".jpg
          fi;
        done
      }
      2loop-unzip() {
        for i in "$@"
        do
          if [ "${i: -4}" == ".zip" ]; then
            unzip "$i"
          fi;
        done
      }
      2ls-exclude-same-name-diff-ext() { for f in *; do echo "${f%.*}"; done | sort | uniq -u ;}
alias 2ls-symlink="find . -maxdepth 1 -type l"
      2ls-tar() { tar tf $1 | sed 's/\/.*//' | uniq; } # list tarball file and folders (depth = 1)
alias 2ls-vidlength='for i in $(ls); do echo -n "$i - " && mediainfo --Inform="Video;%Duration/String%" $i; done'
      2mount() {
        sudo mount /dev/${1} ~/mnt/${1}
      }
      2mount-ms() {
        sudo mount -o rw,user,uid=1000,dmask=007,fmask=117 /dev/${1} ~/mnt/${1}
      }
      2mount-luks() {
        sudo cryptsetup luksOpen /dev/"${1}" "${1}"
#         su -c "cryptsetup luksOpen /dev/${1} ${1}"
        sudo mount /dev/mapper/${1} ~/mnt/${1}
      }
      2ms2date() {
        perl -e "print scalar localtime($1 / 1000)" && echo
      }
      2mv-batch() {
        tempfile=$(mktemp); old=(*); printf "%s\n" "${old[@]}" > $tempfile; $EDITOR $tempfile; readarray -t new < $tempfile; for i in ${!old[*]}; do if [ "${old[i]}" != "${new[i]}" ]; then mv "${old[i]}" "${new[i]}"; fi; done; rm $tempfile
#         TODO in new file tell preserves sequence and do not remove this line
      }
alias 2ping="ping gnu.org"
      2port-kill() { sudo fuser -k $1/tcp; }
alias 2primary-get="xclip -o -selection primary"
alias 2pwd-s="pwd | tr -d '\n' | xclip -selection clipboard"
alias 2r="ranger"
alias 2replace-newline="tr '\n' ' '"
      2rotate-pic() {
        for i in "$@"
        do
#           echo "$i"
          convert "$i" -rotate 90 "$i"
        done
      }
alias 2rm-file-recursive="find . -type f -delete"
      2sed-replace-recursive() {
        find . -type f -not -path '*/\.*' -exec sed -i "s|$1|$2|g" {} +;
      }
      2server() {
        arg="${1}"
        if [[ $# -eq 0 ]] ; then
          python -m http.server 5000
        elif [ $arg == 'python' ]; then
          python -m http.server 5000
        elif [ $arg == 'hoogle' ]; then
          hoogle server --local -n -p 5000
        fi;
      }
alias 2setxkbmap="setxkbmap -layout us,th -option 'grp:toggle'"
      2source() {
        if [[ $# -eq 0 ]] ; then
          echo 'usage: 2source <program>'
        fi;

        local c=
        case "$1" in
          bash) c="source ~/.bashrc" ;;
        esac

        if [ -n "$c" ]; then
          echo "$c"; eval "$c"
        else
          echo unknown arguments
        fi;
      }
alias 2t="type"
      2tab-title-change() { echo -en "\e]2;$1\a"; }
      2umount() {
        sudo umount ~/mnt/${1}
      }
      2umount-luks() {
        sudo umount ~/mnt/$1
        sudo cryptsetup luksClose /dev/mapper/"${1}"
#         su -c "cryptsetup luksClose /dev/mapper/$1"
      }
alias 2w='which'
alias 2watch-power='watch cat /sys/class/power_supply/BAT*/power_now'

# ---
# specific
## --- QubesOS
alias 2qubes-nix-apply="home-manager switch --impure --flake \"path:/home/user/configs-and-scripts/configs/nix/qubes-os/${HOSTNAME}#user\""
      2qubes-connect-port() {
        qvm-connect-tcp ::"$1"
      }
