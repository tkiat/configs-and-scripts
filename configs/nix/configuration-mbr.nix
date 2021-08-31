{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/packages-custom.nix
      ./modules/packages-system.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest-libre;
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

  hardware = {
    enableRedistributableFirmware = false;
    firmware = [
      (
        pkgs.runCommand "open-ath9k-htc-firmware" { } ''
          mkdir -p $out/lib/firmware
          cp ${./htc_9271.fw} $out/lib/firmware/htc_9271.fw
        ''
      )
    ];
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

  nixpkgs.config = {
    allowBroken = true;
    blacklistedLicenses = with lib.licenses; [
      # despite being non-free, NixOS doesn't treat unfreeRedistributableFirmware as such
      unfreeRedistributableFirmware
    ];
  };

  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "ondemand";
    enable = true;
  };

  programs = {
    gnupg.agent.enable = true;
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
