{ config, pkgs, ... }:

{
  environment = {
    systemPackages =
      with pkgs;
      [
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
        mc
        mediainfo
        mupdf
        neofetch
        neomutt
        newsboat
        nixpkgs-fmt
        nodejs
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
        vim_configurable
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
        yarn
        zip
      ];
  };
}