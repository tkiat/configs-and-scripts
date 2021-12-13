{ config, pkgs, ... }:
let
  my-config = "/home/tkiat/configs-and-scripts/configs";
  my-private = "/home/tkiat/Sync/Personal-Local/Private";
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

    acpi
    alsaUtils
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
    ghostscript
    gnupg
    gwenview
    heimdall
    htop
    imagemagick
    jpegoptim
    killall
    less
    lm_sensors
    loc
    mc
    mediainfo
    neofetch
    neovim
    openbox
    pciutils
    pencil
    pinentry
    pinta
    qview
    ranger
    redshift
    ripgrep
    rsync
    scrot
    smartmontools
    tealdeer
    tmux
    trash-cli
    unzip
    usbutils
    w3m
    wget
    xclip
    xfce.exo
    xfce.thunar
    xfce.tumbler
    xfce.xfconf
    xmonad-with-packages
    xsel
    xterm
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

      file.".ssh/GitHub-tkiatd".source = "${my-private}/ssh/GitHub-tkiatd";
      file.".ssh/GitLab-tkiatd".source = "${my-private}/ssh/GitLab-tkiatd";
      file.".ssh/NotABug-tkiat".source = "${my-private}/ssh/NotABug-tkiat";

      file.".ssh/config".source = "${my-config}/ssh/config";
      file.".ssh/GitHub-tkiatd.pub".source = "${my-config}/ssh/GitHub-tkiatd.pub";
      file.".ssh/GitLab-tkiatd.pub".source = "${my-config}/ssh/GitLab-tkiatd.pub";
      file.".ssh/NotABug-tkiat.pub".source = "${my-config}/ssh/NotABug-tkiat.pub";

      file.".xmonad/xmonad.hs".source = "${my-config}/xmonad/xmonad.hs";
      file.".local/share/fonts/comic shanns 2.ttf".source = "${my-config}/font/comic-shanns/v2/comic shanns 2.ttf";

      packages = with pkgs; [
        # dev
        ansible
        bash
        cabal-install
          # cookiecutter
        docker
        docker-compose
        gcc
        gnumake
        go
        graphviz
        jq
        lua
        niv
        nix-prefetch-git
        python3
        sass
        shellcheck
        stack
        tokei
        yarn

        calibre
        cmus
        gdrive
        gimp
        inkscape
        kdenlive
        libreoffice
        mupdf
        neomutt
        newsboat
        okular
        pandoc
        polybar
        simplescreenrecorder
        tdesktop
        tor-browser-bundle-bin
        vlc
        weechat
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
	historyControl = [ "ignoredups" "ignorespace" ]; # ignore duplicates and "^ .*" entries
        historyFileSize = 10000;
        historySize = 10000;
        initExtra = '' # interactive shell
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

	  path_config=~/configs-and-scripts/configs
          path_script=~/configs-and-scripts/scripts

          # Prompt
          . $path_script/onstart/bash_zsh-git_prompt.sh
          GIT_PS1_SHOWDIRTYSTATE=1
          PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0;36m\]$(__git_ps1)\[\033[0m\]\$ ";

          # Completion
          if ! shopt -oq posix; then . $path_script/onstart/bash_zsh-git_completion.bash; fi
          bind 'TAB':menu-complete # cycle through completion matches
          bind "set show-all-if-ambiguous on" # display a list of matching files
          bind "set menu-complete-display-prefix on"
          
          [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # make less friendly for like *.tar.gz
	  PATH=$PATH:$path_script/ondemand
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
      chromium = {
        enable = true;
	extensions = [
          { id = "lhdoppojpmngadmnindnejefpokejbdd"; } # axe devtools
          { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
          { id = "ammoloihpcbognfddfjcljgembpibcmb"; } # javascript restrictor
          { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # react devtools
          { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
          { id = "cdockenadnadldjbbgcallicgledbeoc"; } # visBug

          { id = "npadhaijchjemiifipabpmeebeelbmpd"; } # theme - material dark
        ];
	package = pkgs.chromium;
	# package = pkgs.ungoogled-chromium;
      };
      firefox = {
        enable = true;
	profiles.default = {
	  id = 0;
	  bookmarks = {
	    Github = {
	      url = "https://github.com/tkiat?tab=repositories";
	    };
	    Gitlab = {
	      url = "https://gitlab.com/";
	    };
	    GOG = {
	      url = "https://www.gog.com/";
	    };
	    "Grammarly" = {
	      url = "https://app.grammarly.com/ddocs/880707227";
	    };
	    "Humble Bundle" = {
	      url = "https://www.humblebundle.com/bundles?hmb_source=navbar";
	    };
	    Kaidee = {
	      url = "https://www.kaidee.com/member/listing";
	    };
	    Outlook = {
	      url = "https://outlook.live.com/mail/0/inbox";
	    };
	    Shopee = {
	      url = "https://shopee.co.th/";
	    };
	    "Stack Overflow" = {
	      url = "https://stackoverflow.com/";
	    };
	    Tutanota = {
	      url = "https://mail.tutanota.com/";
	    };
          };
	  settings = {
	    "browser.newtabpage.activity-stream.feeds.section.highlights" = false; # home screen content
	    "browser.newtabpage.activity-stream.feeds.snippets" = false;
	    "browser.newtabpage.activity-stream.feeds.topsites" = false;
	    "browser.newtabpage.activity-stream.showSearch" = false; # home screen content
            "browser.startup.page" = 3; # Open previous windows and tabs
	    "browser.search.defaultenginename" = "DuckDuckGo";
            "browser.search.isUS" = false;
            "browser.search.region" = "TH";
	    "browser.search.selectedEngine" = "DuckDuckGo";
	    "browser.search.suggest.enabled" = false;
	    "browser.shell.checkDefaultBrowser" = false;
	    "browser.toolbars.bookmarks.visibility" = "never";
	    "browser.uidensity" = 1; # compact
	    "browser.urlbar.placeholderName" = "whatever you want"; # get overwritten
	    "browser.urlbar.suggest.bookmark" = false;
	    "browser.urlbar.suggest.engines" = false;
	    "browser.urlbar.suggest.history" = false;
	    "browser.urlbar.suggest.openpage" = false;
	    "browser.urlbar.suggest.topsites" = false;
	    "dom.webnotifications.enabled" = false;
	    "permissions.default.desktop-notification" = 2; # disable
	    "signon.rememberSignons" = false; # never save logins and passwords
          };
	};
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
        enable = true;
	extraConfig = ''
          let mapleader=','
	  let s:root_dir="${my-config}/neovim/init"

	  luafile ${my-config}/neovim/init/lsp.lua

	  exe "source ".s:root_dir."/shared.vim"
	  exe "source ".s:root_dir."/template.vim"
	  exe "source ".s:root_dir."/colorscheme.vim"
	  exe "source ".s:root_dir."/comment.vim"
	  exe "source ".s:root_dir."/completion.vim"
	  exe "source ".s:root_dir."/html.vim"
	  exe "source ".s:root_dir."/syntax.vim"
	'';
        plugins = with pkgs.vimPlugins; [
	 completion-nvim
         # dhall-vim
         emmet-vim
         nerdtree
         nvim-lspconfig
         nvim-treesitter
         purescript-vim
         vim-nix
         vim-toml
	];
      };
      newsboat = {
        enable = true;
        extraConfig = ''
          unbind-key C
          unbind-key h
          unbind-key j
          unbind-key k
          unbind-key l
          unbind-key o
          unbind-key w
          
          bind-key ^D pagedown
          bind-key ^U pageup
          bind-key d toggle-show-read-feeds
          bind-key h quit
          bind-key j down
          bind-key k up
          bind-key l open
          bind-key w open-in-browser
          browser chromium
          color article             white   black
          color background          white   black
          color info                white   black      bold
          color listfocus           white   color240   bold
          color listfocus_unread    magenta color240   bold
          color listnormal          white   black
          color listnormal_unread   magenta black
          datetime-format "%L"
          history-limit 0 # search history
          keep-articles-days 7
          macro c open-in-browser
          macro f set browser "firefox %u"; open-in-browser ; set browser chromium
          macro i set browser "icecat %u"; open-in-browser ; set browser chromium
          macro q set browser "qutebrowser %u"; open-in-browser ; set browser chromium
          macro u set browser "ungoogled-chromium --incognito %u"; open-in-browser ; set browser chromium
          macro w set browser "w3m %u"; open-in-browser ; set browser chromium
          # max-items 100
          # refresh-on-startup yes
          show-read-articles no
          show-read-feeds no
	'';
        urls = [
          { tags = [ "~Crapple" ] ; url = "https://www.apple.com/newsroom/rss-feed.rss"; }
          { tags = [ "~Dilbert" ] ; url = "https://dilbert.com/feed"; }
          { tags = [ "~Standard Ebooks" ] ; url = "https://standardebooks.org/rss/new-releases"; }

          { tags = [ "~CopyBlogger" ] ; url = "https://copyblogger.com/feed/"; }
          { tags = [ "~ProBlogger" ] ; url = "https://feeds.feedblitz.com/ProBlogger"; }

          { tags = [ "~Debian" ] ; url = "http://debian-handbook.info/feed/"; }
          { tags = [ "~Distrowatch" ] ; url = "https://distrowatch.com/news/dww.xml"; }
          { tags = [ "~Fedora Magazine" ] ; url = "https://fedoramagazine.org/feed/"; }
          { tags = [ "~Guix" ] ; url = "http://guix-website-test.cbaines.net/feeds/blog.atom"; }
          { tags = [ "~Linux Journal" ] ; url = "https://www.linuxjournal.com/node/feed"; }
          { tags = [ "~Linux Magazine" ] ; url = "https://www.linux-magazine.com/rss/feed/lmi_news"; }
          { tags = [ "~LWN.net" ] ; url = "https://lwn.net/headlines/rss"; }
          { tags = [ "~NixOS" ] ; url = "https://weekly.nixos.org/feeds/all.rss.xml"; }

          { tags = [ "~freeCodeCamp" ] ; url = "https://www.freecodecamp.org/news/rss/"; }
          { tags = [ "~FSF" ] ; url = "https://static.fsf.org/fsforg/rss/news.xml"; }
          { tags = [ "~GitLab" ] ; url = "https://about.gitlab.com/atom.xml"; }
          { tags = [ "~Opensource.com" ] ; url = "https://opensource.com/feed"; }
          { tags = [ "~PodRocker" ] ; url = "https://feeds.fireside.fm/podrocket/rss"; }
          { tags = [ "~Real Python" ] ; url = "https://realpython.com/atom.xml"; }

          { tags = [ "~A List Apart" ] ; url = "https://alistapart.com/main/feed/"; }
          { tags = [ "~Codrops" ] ; url = "https://tympanus.net/codrops/feed/"; }
          { tags = [ "~CSS Tricks" ] ; url = "https://css-tricks.com/feed/"; }
          { tags = [ "~Kevin Powell" ] ; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJZv4d5rbIKd4QHMPkcABCw"; }
          { tags = [ "~Lea Verou" ] ; url = "http://feeds.feedburner.com/leaverou"; }
          { tags = [ "~Overreacted" ] ; url = "https://overreacted.io/rss.xml"; }
          { tags = [ "~Smashing Magazine" ] ; url = "https://www.smashingmagazine.com/feed/"; }
        ];
      };
      password-store = {
        enable = true; # git clone folder to /password-store
        settings = {
          PASSWORD_STORE_DIR = "/home/tkiat/.password-store";
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
      vscode = {
        enable = true;
	package = pkgs.vscodium;
	# extensions = [ pkgs.vscode-extensions.bbenoist.Nix ];
	# haskell = {
	#   enable = true;
        # };
	# userSettings = {
	#   "update.channel" = "none";
        #   "[nix]"."editor.tabSize" = 2;
	# };
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
