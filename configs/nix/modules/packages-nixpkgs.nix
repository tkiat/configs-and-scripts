{ config, pkgs, ... }:

{
  environment = {
    systemPackages =
      with pkgs;
      [
        # LSP
        haskell-language-server
        pyright
        nodePackages.bash-language-server
        nodePackages.purescript-language-server
        nodePackages.typescript-language-server
        nodePackages.vim-language-server
        nodePackages.yaml-language-server

        # autoformatter
        haskellPackages.brittany
        nixpkgs-fmt

        # completion


        # vim
        vim
        (neovim.override {
          configure = {
            customRC = ''
              let initial_file = "/home/".$USER."/.config/nvim/init.vim"
              if filereadable(initial_file)
                exec "source ".initial_file
              endif
            '';
            packages.myVimPackage = with pkgs.vimPlugins;
              {
                start = [ completion-nvim dhall-vim emmet-vim nerdtree nvim-lspconfig nvim-treesitter purescript-vim vim-nix vim-toml ];
                # manually loadable by calling `:packadd $plugin-name`
                opt = [ ];
                # To automatically load a plugin when opening a filetype, add vimrc lines like:
                # autocmd FileType php :packadd phpCompletion
              };
          };
        })

        # dev
        ansible
        bash
        docker
        docker-compose
        gcc
        ghc
        git
        gnumake
        lua
        purescript
        python3
        shellcheck
        spago
        stack

        acpi
        alsaUtils
        bat
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
        gnome.zenity
        gnupg
        gwenview
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
        mc
        mediainfo
        mupdf
        neofetch
        neomutt
        newsboat
        nodejs
        nvimpager
        pandoc
        pass
        pencil
        pinentry
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
        tor-browser-bundle-bin
        trash-cli
        tree
        ungoogled-chromium
        unzip
        usbutils
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
