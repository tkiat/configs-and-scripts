{ config, pkgs, lib, ... }:

let
  ghc' = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    lens
    mtl
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
      blacklistedLicenses = with lib.licenses; [
        # NixOS doesn't treat unfreeRedistributableFirmware as unfree
        unfreeRedistributableFirmware
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # unfree
    google-chrome
    unrar

    dmenu

    nodePackages.bash-language-server
    nodePackages.yaml-language-server

    acpi
    alsaUtils
    bash
    bat
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
    gcc
    ghc'
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
    python3
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
}
