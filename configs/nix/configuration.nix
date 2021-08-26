{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  #   nixpkgs.config.allowBroken = true;

  boot = {
    blacklistedKernelModules = [
      "iwlwifi"
    ];
    # kernelPackages = pkgs.linuxPackages;
    # kernelPackages = pkgs.linuxPackages_latest-libre;
    kernelPackages = pkgs.linuxPackages-libre;
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
      ansible
      bash
      dmenu
      firefox
      gnupg
      git
      slock
      st
      vim_configurable
      wget
      xmobar
    ];
  };

  hardware = {
    # firmware = [
    #   (
    #     pkgs.runCommandNoCC "open-ath9k-htc" { } ''
    #       mkdir -p $out/lib/firmware
    #       cp ${./htc_9271.fw} $out/lib/firmware/htc_9271.fw
    #     ''
    #   )
    # ];
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
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs = {
    slock.enable = true; # SUID wrappers
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
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
      # libinput.enable = true; # touchpad support
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

  swapDevices = [
    {
      label = "swap";
    }
  ];


  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05";

  time = {
    timeZone = "Asia/Bangkok";
  };

  users = {
    mutableUsers = false;
    users.tkiat = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
      uid = 1000;
    };
  };
}
