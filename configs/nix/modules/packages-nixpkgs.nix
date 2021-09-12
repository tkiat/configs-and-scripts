{ config, pkgs, ... }:

# let
#   unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
# in
{
#   nixpkgs.config.packageOverrides = pkgs: {
#     unstable = import unstableTarball {
#       config = config.nixpkgs.config;
#     };
#   };

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
        sumneko-lua-language-server

        # autoformatter
        haskellPackages.brittany
        haskellPackages.ormolu
        nixpkgs-fmt

        # dev
        ansible
        bash
        cabal-install
        cabal2nix
        cookiecutter
        docker
        docker-compose
        gcc
        ghc
        git
        gnumake
        lua
        niv
        nix-prefetch-git
        nodejs
        purescript
        python3
        shellcheck
        spago
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
        nvimpager
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
        vscodium
        w3m
        weechat
        wget
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
