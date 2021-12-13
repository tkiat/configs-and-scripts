{ config, pkgs, lib, ... }:

{
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "google-chrome"
      ];
      blacklistedLicenses = with lib.licenses; [
        # NixOS doesn't treat unfreeRedistributableFirmware as unfree
        unfreeRedistributableFirmware
      ];
    };
  };

  environment = {
    systemPackages =
      with pkgs;
      [
        # unfree
        google-chrome

        # LSP
          # haskell-language-server
        nodePackages.bash-language-server
          # nodePackages.purescript-language-server
          # nodePackages.typescript-language-server
          # nodePackages.vim-language-server
        nodePackages.yaml-language-server
          # pyright
        sumneko-lua-language-server

        # dev
        ansible
        bash
        cabal-install
#         cabal2nix
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
        #         nodejs
        #         purescript
        python3
        sass
        shellcheck
        #         spago
        stack

        # others
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
        tor-browser-bundle-bin
        trash-cli
        tree
        ungoogled-chromium
        unzip
        usbutils
        vlc
        #         vscodium
        w3m
        weechat
        wget
        xclip
        xfce.exo
        xfce.thunar
        xfce.tumbler
        xfce.xfconf
        xmobar
        xmonad-with-packages
        xsel
        xterm
        yarn
        zip
      ];
  };
}
