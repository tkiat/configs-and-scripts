{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # nixpkgs.config.allowBroken = true;

  boot = {
    blacklistedKernelModules = [
      "iwlwifi"
    ];
    kernelPackages = pkgs.linuxPackages;
    # kernelPackages = pkgs.linuxPackages_latest-libre;
    initrd.luks.devices.root = {
      device = "/dev/disk/by-uuid/831e92d5-4f9e-4f62-9ec4-0a649ab64ec9";
      preLVM = true;
    };
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
      };
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment = {
    systemPackages = with pkgs; [
      acpi
      alsa-utils
      ansible
      bash
      bat
      calibre
      cmus
      cpufrequtils
      curl
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
      git-repo
      gnumake
      gnupg
      gwenview
      haskell-language-server
      heimdall
      htop
      imagemagick
      inkscape
      jpegoptim
      kdenlive
      less
      libreoffice
      loc
      lm-sensors
      mc
      mediainfo
      mupdf
      neofetch-unstable
      neomutt
      newsboat
      nixpkgs-fmt
      pandoc
      password-store
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
      tealdeer
      telegram-desktop
      thunar
      tmux
      tokei
      tor-browser-bundle-bin
      trash-cli
      tree
      tumbler
      ungoogled-chromium
      unzip
      vim_configurable
      vlc
      vscodium
      w3m
      weechat
      wget
      xmobar
      xmonad-with-packages
      yarn
      zenity
      zip
    ];
  };

  hardware = {
    pulseaudio.enable = true;
    trackpoint.emulateWheel = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    hostName = "nixos";
    interfaces.eno0.useDHCP = true;
    # interfaces.wlp2s0.useDHCP = true;
    networkmanager.enable = true;
    useDHCP = false;
  };

  programs = {
    slock.enable = true; # SUID wrappers
  };

  powerManagement = {
    cpuFreqGovernor = "ondemand";
    enable = true;
  };

  services = {
    openssh.enable = true;
    printing.enable = true; # CUPS
    xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      layout = "us,th";
      # libinput.enable = true; # touchpad
      windowManager = {
        xmonad.enable = true;
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

  system.stateVersion = "21.05";

  time = {
    timeZone = "Asia/Bangkok";
  };

  users = {
    users.tkiat = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      uid = 1000;
    };
  };
}
