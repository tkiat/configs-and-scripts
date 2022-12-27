{ config, lib, pkgs, ... }:

let
  ghc' = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    lens
    mtl
    random
    transformers
  ]);
  my-config = "/home/tkiat/configs-and-scripts/configs";
  my-cloud = "/home/tkiat/cloud";
  my-private = "/home/tkiat/private";
in
{
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "google-chrome"
        "Oracle_VM_VirtualBox_Extension_Pack"
        "unrar"
      ];
    };
  };
  # fonts.fontconfig.enable = true;
  home = {
    enableNixpkgsReleaseCheck = true;
    # home.file.".foo".source = config.lib.file.mkOutOfStoreSymlink /my/config/repo/foo;

#     file."Downloads".source = config.lib.file.mkOutOfStoreSymlink "${my-local}/downloads";

    file.".config/xmobar/.xmobarrc".source = "${my-config}/xmobar/.xmobarrc";
    file.".local/share/fonts/comic shanns 2.ttf".source = "${my-config}/font/comic-shanns/v2/comic shanns 2.ttf";
    file.".inputrc".text = ''
      set completion-ignore-case on
    '';
    file.".newsboat/config".source = "${my-config}/newsboat/config";
    file.".newsboat/urls".source = "${my-config}/newsboat/urls";
    file.".config/polybar/config.ini".source = "${my-config}/polybar/config.ini";
    file.".local/share/pomodoro-bar/record.json".source = config.lib.file.mkOutOfStoreSymlink "${my-cloud}/app/pomodoro-bar/record.json";

    file.".ssh/GitHub-tkiatd".source = "${my-private}/ssh/GitHub-tkiatd";
    file.".ssh/GitLab-tkiatd".source = "${my-private}/ssh/GitLab-tkiatd";
    file.".ssh/NotABug-tkiat".source = "${my-private}/ssh/NotABug-tkiat";

    file.".ssh/config".source = "${my-config}/ssh/config";
    file.".ssh/GitHub-tkiatd.pub".source = "${my-config}/ssh/GitHub-tkiatd.pub";
    file.".ssh/GitLab-tkiatd.pub".source = "${my-config}/ssh/GitLab-tkiatd.pub";
    file.".ssh/NotABug-tkiat.pub".source = "${my-config}/ssh/NotABug-tkiat.pub";

    file.".xinitrc".source = "${my-config}/xorg/.xinitrc";
    file.".xmonad/xmonad.hs".source = "${my-config}/xmonad/xmonad.hs";
    file.".xpdfrc".source = "${my-config}/xpdf/.xpdfrc";
    file.".Xresources".source = "${my-config}/xorg/.Xresources";

#     file.".config/nvim/init".source = "${my-config}/neovim/init";
#     file.".config/nvim/init".recursive = true;

    packages = with pkgs; [
      # unfree
      google-chrome
      unrar

      # dev
#       ansible
      cabal-install
        # cookiecutter
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
      bash
      bat
#       busybox
      calc
#       calibre
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
#       ghostscript
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
#       libnotify
      libreoffice
      lm_sensors
      loc
      lshw
      mc
      mediainfo
      mupdf
      neofetch
      neomutt
#       neovim
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
      xfce.exo
      xfce.thunar
      xfce.tumbler
      xfce.xfconf
      xterm
      vlc
      weechat
      zip
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    stateVersion = "23.05";
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
      . ${my-config}/alias/modules/nixos.alias
      . ${my-config}/alias/modules/systemctl.alias

      # . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
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
#         bookmarks = {
#           Github = {
#             url = "https://github.com/tkiat?tab=repositories";
#           };
#           Gitlab = {
#             url = "https://gitlab.com/";
#           };
#           Grammarly = {
#             url = "https://app.grammarly.com/ddocs/880707227";
#           };
#           "Humble Bundle" = {
#             url = "https://www.humblebundle.com/bundles?hmb_source=navbar";
#           };
#           Kaidee = {
#             url = "https://www.kaidee.com/member/listing";
#           };
#           Outlook = {
#             url = "https://outlook.live.com/mail/0/inbox";
#           };
#           Reddit = {
#             url = "https://www.reddit.com/";
#           };
#           Shopee = {
#             url = "https://shopee.co.th/";
#           };
#           "Stack Overflow" = {
#             url = "https://stackoverflow.com/";
#           };
#           Thairath = {
#             url = "https://www.thairath.co.th/newspaper";
#           };
#           Tutanota = {
#             url = "https://mail.tutanota.com/";
#           };
#           "Utility - MEA" = {
#             url = "https://eservice.mea.or.th/meaeservice/";
#           };
#           "Utility - MWA" = {
#             url = "https://eservicesapp.mwa.co.th/ES/main.jsp";
#           };
#         };
#         settings = {
#           "browser.download.folderList" = 1; # 1 is ~/Downloads
#           "browser.download.lastDir" = "/home/tkiat/downloads";
#           "browser.newtabpage.activity-stream.feeds.section.highlights" = false; # home screen content
#           "browser.newtabpage.activity-stream.feeds.snippets" = false;
#           "browser.newtabpage.activity-stream.feeds.topsites" = false;
#           "browser.newtabpage.activity-stream.showSearch" = false; # home screen content
#           "browser.search.defaultenginename" = "DuckDuckGo";
#           "browser.search.isUS" = false;
#           "browser.search.region" = "TH";
#           "browser.search.selectedEngine" = "DuckDuckGo";
#           "browser.search.suggest.enabled" = false;
#           "browser.shell.checkDefaultBrowser" = false;
#           "browser.startup.page" = 3; # Open previous windows and tabs
#           "browser.toolbars.bookmarks.visibility" = "never";
#           "browser.uidensity" = 1; # compact
#           "browser.urlbar.placeholderName" = "whatever you want"; # get overwritten
#           "browser.urlbar.suggest.bookmark" = false;
#           "browser.urlbar.suggest.engines" = false;
#           "browser.urlbar.suggest.history" = false;
#           "browser.urlbar.suggest.openpage" = false;
#           "browser.urlbar.suggest.topsites" = false;
#           "dom.webnotifications.enabled" = false;
#           "network.protocol-handler.external.mailto" = false; # mailto warning
#           "permissions.default.desktop-notification" = 2; # disable
#           "signon.rememberSignons" = false; # never save logins and passwords
#         };
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
    password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "/home/tkiat/.password-store";
      };
    };
    texlive = {
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
  };
}
