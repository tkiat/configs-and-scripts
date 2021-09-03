{ config, pkgs, ... }:

{
  environment = {
    systemPackages =
      with pkgs;
      [
        # LSP
        pyright

        # vim
        vimPlugins.vim-nix
        (neovim.override {
          configure = {
            customRC = "source /home/tkiat/.config/nvim/init.vim";
            packages.myVimPackage = with pkgs.vimPlugins; {
              start = [ dhall-vim emmet-vim nerdtree nvim-lspconfig purescript-vim vim-nix vim-toml ];
              # manually loadable by calling `:packadd $plugin-name`
              opt = [ ];
              # To automatically load a plugin when opening a filetype, add vimrc lines like:
              # autocmd FileType php :packadd phpCompletion
            };
          };
        })

        acpi
        alsaUtils
        ansible
        bash
        bat
        calibre
        cmus
        cpufrequtils
        curl
        dash
        dejsonlz4
        dmidecode
        docker
        docker-compose
        du-dust
        exa
        fd
        feh
        flashrom
        firefox
        gcc
        gdrive
        ghc
        ghostscript
        gimp
        git
        gnome.zenity
        gnumake
        gnupg
        gwenview
        haskell-language-server
        haskellPackages.brittany
        heimdall
        htop
        imagemagick
        inkscape
        jpegoptim
        kdenlive
        less
        libreoffice
        lm_sensors
        loc
        lua
        mc
        mediainfo
        mupdf
        neofetch
        neomutt
        newsboat
        nixpkgs-fmt
        nodejs
        nvimpager
        pandoc
        pass
        pencil
        pinentry
        purescript
        python3
        qview
        ranger
        redshift
        ripgrep
        rsync
        scrot
        shellcheck
        simplescreenrecorder
        smartmontools
        spago
        tdesktop
        tealdeer
        tmux
        tokei
        tor-browser-bundle-bin
        trash-cli
        tree
        ungoogled-chromium
        unzip
        usbutils
        vim
        #         vim_configurable
        vlc
        vscodium
        w3m
        weechat
        wget
        xfce.exo
        xfce.thunar
        xfce.tumbler
        xfce.xfconf
        xsel
        xmobar
        xmonad-with-packages
        yarn
        zip
      ];
  };
}
