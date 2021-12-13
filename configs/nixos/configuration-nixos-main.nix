{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./configuration-shared/home-manager.nix
    ];

  boot = {
    initrd.luks.devices.root = {
      device = "/dev/disk/by-uuid/db330814-0813-4f1f-a01e-bb50f2ae0a58";
      preLVM = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub = {
      device = "/dev/sda";
      enable = true;
      version = 2;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    dmenu

    acpi
    alsaUtils
    bash
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

  hardware = {
    enableRedistributableFirmware = false;
    pulseaudio.enable = true;
    trackpoint.emulateWheel = true;
  };


  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "nixos-main";
    interfaces.eno0.useDHCP = true;
    networkmanager.enable = true;
    useDHCP = false;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  programs = {
    flashrom.enable = true;
    gnupg.agent.enable = true;
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      layout = "us, th";
      windowManager = {
        xmonad.enable = false;
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
  system.stateVersion = "21.11"; # shouldn't change this unless you know what you are doing
  time.timeZone = "Asia/Bangkok";

  users.users.tkiat = {
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    uid = 1000;
  };

  virtualisation.docker.enable = true;
}
