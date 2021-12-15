{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  my-config = "/home/tkiat/configs-and-scripts/configs";
  my-private = "/home/tkiat/Sync/Personal-Local/Private";
  nur-no-pkgs = import pkgs.nur {
    nurpkgs = import pkgs { system = "x86_64-linux"; };
  };
in
{
  imports =
    [
      nur-no-pkgs.repos.rycee.firefox-addons
      (import "${home-manager}/nixos")
    ];
  home-manager.users.tkiat = { pkgs, ... }: {
    # dconf.setttings = {
    # }
    # fonts.fontconfig.enable = true;
    home = {
      enableNixpkgsReleaseCheck = true;
      # home.file.".foo".source = config.lib.file.mkOutOfStoreSymlink /my/config/repo/foo;

      file.".config/xmobar/.xmobarrc".source = "${my-config}/xmobar/.xmobarrc";
      file.".local/share/fonts/comic shanns 2.ttf".source = "${my-config}/font/comic-shanns/v2/comic shanns 2.ttf";
      file.".inputrc".text = ''
        set completion-ignore-case on
      '';
      file.".newsboat/config".source = "${my-config}/newsboat/config";
      file.".newsboat/urls".source = "${my-config}/newsboat/urls";
      file.".config/polybar/config.ini".source = "${my-config}/polybar/config.ini";

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

      packages = with pkgs; [
        # dev
        ansible
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
        xmobar
      ];
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
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
            Reddit = {
              url = "https://www.reddit.com/";
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
          dhall-vim
          emmet-vim
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
  };
}
