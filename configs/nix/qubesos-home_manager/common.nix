{ lib, pkgs, specialArgs, ... }:

let
  my-config = "/home/${specialArgs.username}/configs-and-scripts/configs";
  ghc' = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    lens
    mtl
    random
    transformers
  ]);
in
{
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "google-chrome"
        "unrar"
      ];
    };
  };
  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
      ''; # non-interactive shell
      initExtra = '' # interactive shell
        . ${my-config}/bash/.bashrc.shared
        . ${my-config}/alias/shared.alias
        . ${my-config}/alias/modules/nix.alias
        # . ${my-config}/alias/modules/nixos.alias
        . ${my-config}/alias/modules/systemctl.alias

        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        export QUBES_GPG_DOMAIN=my-vault

        # SPLIT SSH CONFIGURATION >>>
        # replace "vault" with your AppVM name which stores the ssh private key(s)
        SSH_VAULT_VM="my-vault"

        if [ "$SSH_VAULT_VM" != "" ]; then
          export SSH_AUTH_SOCK="/home/user/.SSH_AGENT_$SSH_VAULT_VM"
        fi
        # <<< SPLIT SSH CONFIGURATION
      '';
      profileExtra = ''
        # if running bash
        if [ -n "$BASH_VERSION" ]; then
            # include .bashrc if it exists
            if [ -f "$HOME/.bashrc" ]; then
          . "$HOME/.bashrc"
            fi
        fi

        # set PATH so it includes user's private bin if it exists
        if [ -d "$HOME/bin" ] ; then
            PATH="$HOME/bin:$PATH"
        fi

        # set PATH so it includes user's private bin if it exists
        if [ -d "$HOME/.local/bin" ] ; then
            PATH="$HOME/.local/bin:$PATH"
        fi

        if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
      '';
      shellOptions =  [ ];
    };
    chromium = {
      enable = true;
      extensions = [
        { id = "lhdoppojpmngadmnindnejefpokejbdd"; } # axe devtools
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
        { id = "ammoloihpcbognfddfjcljgembpibcmb"; } # javascript restrictor
        { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # react devtools
        { id = "npadhaijchjemiifipabpmeebeelbmpd"; } # theme - material dark
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
        { id = "cdockenadnadldjbbgcallicgledbeoc"; } # visBug
      ];
      package = pkgs.chromium;
      # package = pkgs.ungoogled-chromium;
    };
    firefox = {
      enable = true;
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   privacy-badger
      # ];
      profiles.default = {
        id = 0;
        bookmarks = {
          Github = {
            url = "https://github.com/tkiat?tab=repositories";
          };
          Gitlab = {
            url = "https://gitlab.com/";
          };
          Grammarly = {
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
          Reddit = {
            url = "https://www.reddit.com/";
          };
          Shopee = {
            url = "https://shopee.co.th/";
          };
          "Stack Overflow" = {
            url = "https://stackoverflow.com/";
          };
          Thairath = {
            url = "https://www.thairath.co.th/newspaper";
          };
          Tutanota = {
            url = "https://mail.tutanota.com/";
          };
          "Utility - MEA" = {
            url = "https://eservice.mea.or.th/meaeservice/";
          };
          "Utility - MWA" = {
            url = "https://eservicesapp.mwa.co.th/ES/main.jsp";
          };
        };
        settings = {
          "browser.download.folderList" = 1; # 1 is ~/Downloads
          "browser.download.lastDir" = "/home/tkiat/downloads";
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false; # home screen content
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSearch" = false; # home screen content
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.isUS" = false;
          "browser.search.region" = "TH";
          "browser.search.selectedEngine" = "DuckDuckGo";
          "browser.search.suggest.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.page" = 3; # Open previous windows and tabs
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.uidensity" = 1; # compact
          "browser.urlbar.placeholderName" = "whatever you want"; # get overwritten
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.topsites" = false;
          "dom.webnotifications.enabled" = false;
          "network.protocol-handler.external.mailto" = false; # mailto warning
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
    home-manager.enable = true;
    neovim = {
      enable = true;
      extraConfig = ''
        let mapleader=','
        let s:root_dir="${my-config}/neovim/init"

        exe "source ".s:root_dir."/shared.vim"

        exe "source ".s:root_dir."/colorscheme.vim"
        exe "source ".s:root_dir."/comment.vim"
        exe "source ".s:root_dir."/completion.vim"
        exe "source ".s:root_dir."/html.vim"
        exe "source ".s:root_dir."/plugin.vim"
        exe "source ".s:root_dir."/syntax.vim"
        exe "source ".s:root_dir."/template.vim"

        exe "luafile ".s:root_dir."/lsp.lua"
      '';
      plugins = with pkgs.vimPlugins; [
        completion-nvim
        dhall-vim
        emmet-vim
#         fugitive
        nerdtree
        nvim-lspconfig
        nvim-treesitter
        purescript-vim
        vim-nix
        vim-toml
      ];
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
  };

  home = {
    enableNixpkgsReleaseCheck = true;

    file = {
      ".config/xmobar/.xmobarrc".source = "${my-config}/xmobar/.xmobarrc";
      ".local/share/fonts/comic shanns 2.ttf".source = "${my-config}/font/comic-shanns/v2/comic shanns 2.ttf";
      ".inputrc".text = ''
        set completion-ignore-case on
      '';
      ".newsboat/config".source = "${my-config}/newsboat/config";
      ".newsboat/urls".source = "${my-config}/newsboat/urls";
      ".config/polybar/config.ini".source = "${my-config}/polybar/config.ini";
      # ".local/share/pomodoro-bar/record.json".source = config.lib.file.mkOutOfStoreSymlink "${my-cloud}/app/pomodoro-bar/record.json";
#       ".profile".source = "${my-config}/profile/qubes-os.profile";
      ".xinitrc".source = "${my-config}/xorg/.xinitrc";
      ".xmonad/xmonad.hs".source = "${my-config}/xmonad/xmonad.hs";
      ".xpdfrc".source = "${my-config}/xpdf/.xpdfrc";
      ".Xresources".source = "${my-config}/xorg/.Xresources";
    };

    packages = with pkgs; [
      # unfree
      google-chrome
      unrar

      # dev
      ansible
      cabal-install
      cookiecutter
      docker
      docker-compose
      gnumake
      go
      graphviz
      jq
      lua
      niv
      nix-prefetch-git
      sass
      shellcheck
      stack
      tokei
      yarn

      acpi
      alsaUtils
      bat
  #     busybox
      calc
  #     calibre
      cmus
      cpufrequtils
      curl
      dash
      dejsonlz4
      dmidecode
      du-dust
      edid-decode
      exa
      exfat
      fd
      feh
      flashrom
      gcc
      gdrive
      ghc'
  #     ghostscript
      gimp
      gnome.cheese
      gnome.gedit
      gnome.zenity
      gnupg
      gwenview
      heimdall
      hdparm
      htop
      imagemagick
      inkscape
      jpegoptim
      kdenlive
      killall
      less
  #     libnotify
      libreoffice
      lm_sensors
      loc
      lshw
      mc
      mediainfo
      mupdf
      neofetch
      neomutt
      newsboat
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      okular
      openbox
      pandoc
      pciutils
      pencil
      pinentry
      pinta
      polybar
      python3
      qview
      ranger
      redshift
      ripgrep
      rsync
      scrot
      simplescreenrecorder
      smartmontools
      specialArgs.tkiat-st
      specialArgs.pomodoro-bar
      specialArgs.pomodoro-bar-py
      tdesktop
      tealdeer
      texlive.combined.scheme-full
      thunderbird
      tmux
      tor-browser-bundle-bin
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
      xsel
      xterm
      vlc
      weechat
      zip
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
