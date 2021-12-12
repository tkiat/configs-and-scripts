{ config, pkgs, ... }:
let
  my-config = "/home/tkiat/configs-and-scripts/configs";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  boot = {
    initrd.luks.devices.root = {
      device = "/dev/disk/by-uuid/db330814-0813-4f1f-a01e-bb50f2ae0a58";
      preLVM = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub = {
      device = "/dev/sda";
      enable = true;
      version = 2;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    dmenu
    neovim
    st

    # dev
    ansible
    bash
    cabal-install
    cookiecutter
    docker
    docker-compose
    gcc
    git
    gnumake
    go
    graphviz
    lua
    niv
    nix-prefetch-git
    python3
    sass
    shellcheck
    stack

    # others
    acpi
    alsaUtils
    calibre
    cmus
    cpufrequtils
    curl
    dash
    dejsonlz4
    dmidecode
    du-dust
    exa
    fd
    feh
    flashrom
    firefox
    gdrive
    ghostscript
    gimp
    gnupg
    gwenview
    heimdall
    htop
    imagemagick
    inkscape
    jpegoptim
    kdenlive
    killall
    less
    libreoffice
    lm_sensors
    loc
    mc
    mediainfo
    mupdf
    neofetch
    neomutt
    newsboat
    okular
    openbox
    pandoc
    pass
    pciutils
    pencil
    pinentry
    pinta
    polybar
    qview
    ranger
    redshift
    ripgrep
    rsync
    scrot
    simplescreenrecorder
    smartmontools
    tdesktop
    tealdeer
    tmux
    tokei
    # tor-browser-bundle-bin
    trash-cli
    ungoogled-chromium
    unzip
    usbutils
    vlc
    # vscodium
    w3m
    weechat
    wget
    xclip
    xfce.exo
    xfce.thunar
    xfce.tumbler
    xfce.xfconf
    # xmobar
    xmonad-with-packages
    xsel
    xterm
    yarn
    zip
  ];

  hardware = {
    enableRedistributableFirmware = false;
    pulseaudio.enable = true;
    trackpoint.emulateWheel = true;
  };

  home-manager.users.tkiat = { pkgs, ... }: {
    # dconf.setttings = {
    # }
    # fonts.fontconfig.enable = true;
    home = {
      enableNixpkgsReleaseCheck = true;
      # home.file.".foo".source = /my/config/repo/foo;
      # home.file.".foo".source = config.lib.file.mkOutOfStoreSymlink /my/config/repo/foo;
      file.".xmonad/xmonad.hs".source = "${my-config}/xmonad/xmonad.hs";
      file.".local/share/fonts/comic shanns 2.ttf".source = "${my-config}/font/comic-shanns/v2/comic shanns 2.ttf";

      packages = with pkgs; [
        jq
      ];
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      shellAliases = {
        # nixos
        "2nixos-rebuild"="sudo nixos-rebuild switch";
        "2nixos-upgrade"="sudo nixos-rebuild switch --upgrade";

        # catch typo
        dc="cd";
        ceho="echo";
        ehco="echo";
        gf="fg";
        sl="ls";
        nv="nvim";
        ivm="vim";

        # overwrite default
        alacritty="LIBGL_ALWAYS_SOFTWARE=1 alacritty";
        cat="bat --pager=less";
        cmus="cd ~/Sync/Public/Music/ && cmus && cd -";
        cp="cp --preserve=timestamps";
        df="df -h";
        du="dust";
        dust="dust --depth 1";
        exa="exa --group-directories-first";
        feh="feh --scale-down --auto-zoom";
        fgrep="fgrep --color=auto";
        free="free -h";
        grep="grep --color=auto";
        less="less -r";
        ls="exa -g";
        mc="mc";
        mupdf="mupdf-x11";
        mupdf-dark="mupdf -C aaaaaa -I";
        polybar="polybar xmonad --config-file=~/.config/polybar/config.ini";
        pomodoro-bar="pomodoro-bar -w 50 -b 15 -l 60 --cmdwork 'xset dpms force off' --cmdbreak 'xset dpms force off' --bartype xmobar";
        pomodoro-bar-py="pomodoro-bar-py -w 50 -b 15 -l 60 --cmdwork 'xset dpms force off' --cmdbreak 'xset dpms force off' --bartype xmobar";
        ranger="ranger";
        rg="rg --ignore-case";
        python="python3";
        qutebrowser="qutebrowser --target private-window";
        sudo="sudo "; # enable running alias as superuser$
        telegram-cli="telegram-cli --enable-msg-id --wait-dialog-list";
        tokei="tokei --sort code";
        tree="exa -T";
        xpdf="xpdf -z width";

        # new
        ".."="cd ..";
        "..."="cd ../..";
        "2a"="alias";
        "2bios-ver"="sudo dmidecode | grep 'BIOS Information' -A 2";
        "2brightness-change"="[ -x '$(command -v xrandr)' ] && xrandr --output LVDS-1 --brightness";
        "2chown-u"="sudo chown 1000:1000 -R";
        "2clipboard-get"="xclip -o -selection clipboard";
        "2clipboard-set"="tr -d '\n' | xclip -selection clipboard"; # usage: pwd | 2clipboard-set
        "2clipboard-set_withnewline"="xclip -selection clipboard";
        "2cookiecutter-hint"="echo cookiecutter gh:tkiat/templates --directory='hs-nix'";
        "2cpu-setfreq-ondemand"="for i in {0..$(($(nproc)-1))}; do sudo cpufreq-set -c \$i -g ondemand; done";
        "2diff-folders"="diff -x '.*' -rq";
        "2gpg-edit"="gpg --edit-key tkiat@tutanota.com";
        "2ls-vidlength"="for i in $(ls); do echo -n \"$i - \" && mediainfo --Inform=\"Video;%Duration/String%\" $i";
        "2rm-file-recursive"="find . -type f -delete";
        "2pwd-s"="pwd | tr -d '\n' | xclip -selection clipboard";
        "2git-addconfig"="git config --local include.path ../.gitconfig";
        "2git-push"="git push origin $(git rev-parse --abbrev-ref HEAD)";
        "2git-remote"="git remote -v";
        "2grep-current-dir"="grep -inr . -e ";
        "2grub-make"="sudo grub-mkconfig -o /boot/grub/grub.cfg";
        "2keyring-get-gnu"="wget https://ftp.gnu.org/gnu/gnu-keyring.gpg";
        "2ls-symlink"="find . -maxdepth 1 -type l";
        "2logout"="pkill -u $USER";
        "2ping"="ping gnu.org";
        "2primary-get"="xclip -o -selection primary";
        "2replace-newline"="tr '\n' ' '";
        "2showoff"="neofetch";
        "2w"="which";
      };
    };

    programs = {
      bash = {
        enable = true;
        bashrcExtra = ''
        ''; # non-interactive shell
        historyFileSize = 10000;
        historySize = 10000;
        initExtra = '' # interactive shell
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# Prompt
. ~/configs-and-scripts/scripts/onstart/bash_zsh-git_prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0;36m\]$(__git_ps1)\[\033[0m\]\$ ";
# Completion
if ! shopt -oq posix; then . ~/configs-and-scripts/scripts/onstart/bash_zsh-git_completion.bash; fi
bind 'TAB':menu-complete # cycle through completion matches
bind "set show-all-if-ambiguous on" # display a list of matching files
bind "set menu-complete-display-prefix on"

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # make less friendly for like *.tar.gz
        '';
        shellAliases = {
        };
        sessionVariables = {
        };
	shellOptions =  [ "autocd" "checkjobs" "checkwinsize" "extglob" "globstar" "histappend" ]; 
      };
      bat = {
        enable = true;
      };
      firefox = {
        enable = true;
      };
      git = {
        enable = true;
        aliases = {
          ch = "checkout";
          co = "commit";
          st = "status";
          pu = "push";
        };
        extraConfig = {
          init.defaultBranch = "main";
        };
        userName  = "tkiat";
        userEmail = "tkiat@tutanota.com";
      };
      neovim = {
        # extraPackages = [ ];
      };
      newsboat = {
        # browser = "";
        enable = true;
        # extraConfig = "";
        maxItems = 10;
        urls = [
          { tags = [ "foo" "bar" ] ; url = "http://example.com"; }
        ];
      };
      password-store = {
        enable = true;
        settings = {
          PASSWORD_STORE_DIR = "$XDG_DATA_HOME/password-store";
        };
      };
      readline = {
        # enable = true;
      };
      ssh = {
        # enable = true;
      };
      texlive = {
        # enable = true;
      };
      tmux = {
        # enable = true;
      };
      xmobar = {
        enable = true;
        extraConfig = ''
          Config {
            -- appearance
            alpha = 255, -- opacity from 0 to 255
            bgColor = "black",
            borderColor = "black",
            border = BottomB,
            fgColor = "grey",
            font = "xft:Comic Shanns:pixelsize=16",
            position = Top,
            textOffset = -1,
            -- layout
            sepChar = "%",
            alignSep = "}{",
            template = "%StdinReader% }{ %cpu% %memory% <fc=#82aaff>|</fc> <fc=green>%pomodoro-bar-w%</fc><fc=yellow>%pomodoro-bar-i%</fc> <fc=#82aaff>|</fc> %date%",
            -- behavior
            allDesktops = True,
            hideOnStart = False,
            lowerOnStart = True, -- window is sent the bottom of the stack initially.
            overrideRedirect = True,
            persistent = False, -- enable hiding
            pickBroadest = False, -- pick broadest display
            -- plugin
            commands = [
              Run StdinReader,
              Run Cpu [
                "--template", "CPU <total>%",
                "--Low", "5", "--High", "50",
                "--low", "green", "--normal", "orange", "--high"  ,"red"
              ] 20, -- * 0.1 sec
              Run Memory [
                "--template", "RAM <usedratio>%",
                "--Low", "40", "--High", "60",
                "--low", "green", "--normal", "orange", "--high"  ,"red"
              ] 20,
              Run Date "%_d %a %H:%M:%S" "date" 10,
              Run PipeReader "OMODORO:/tmp/.pomodoro-bar-i" "pomodoro-bar-i",
              Run PipeReader "P:/tmp/.pomodoro-bar-w" "pomodoro-bar-w"
            ]
          }
	'';
      };
    };
    services = {
      password-store-sync = {
        # enable = true;
        frequency = "*:0/5";
      };
      redshift = {
        # enable = true;
        # dawnTime = "6:00-7:45";
        # duskTime = "18:35-20:15";
        # temperature = {
        #   night = 3200;
        # };
      };
    };
    # xsession = {
    #   windowManager = {
    #     xmonad = {
    #       enable = false;
    #       config = pkgs.writeText "xmonad.hs" ''
    #       '';
    #       enableContribAndExtras = true;
    #       extraPackages = haskellPackages: [
    #         haskellPackages.xmonad
    #         haskellPackages.xmonad-contrib
    #         haskellPackages.xmonad-extras
    #       ];
    #     };
    #   };
    # };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "nixos";
    interfaces.eno0.useDHCP = true;
    networkmanager.enable = true;
    useDHCP = false;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  programs = {
    flashrom.enable = true;
    gnupg.agent.enable = true;
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      layout = "us, th";
      windowManager = {
        xmonad.enable = false;
        xmonad.enableContribAndExtras = true;
        xmonad.extraPackages = hpkgs: [
          hpkgs.xmonad
          hpkgs.xmonad-contrib
          hpkgs.xmonad-extras
        ];
      };
      xkbOptions = "grp:alt_space_toggle";
    };
  };

  sound.enable = true;
  system.stateVersion = "21.11"; # shouldn't change this unless you know what you are doing
  time.timeZone = "Asia/Bangkok";

  users.users.tkiat = {
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    uid = 1000;
  };
  
  virtualisation.docker.enable = true;
}
