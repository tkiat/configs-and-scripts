{ lib, pkgs, ... }:

{
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  hardware = {
#     enableRedistributableFirmware = false;
    firmware = [
      (
        pkgs.runCommand "open-ath9k-htc-firmware" { } ''
          mkdir -p $out/lib/firmware
          cp ${/home/tkiat/cloud/nonpersonal/firmware/ath9k-htc-compiled/htc_9271.fw} $out/lib/firmware/htc_9271.fw
        ''
      )
    ];
    pulseaudio.enable = true;
    trackpoint.emulateWheel = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
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

  nixpkgs = {
    config = {
#       allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
#         "google-chrome"
#         "Oracle_VM_VirtualBox_Extension_Pack"
#         "unrar"
#       ];
      blacklistedLicenses = with lib.licenses; [
        # NixOS doesn't treat unfreeRedistributableFirmware as unfree
#         unfreeRedistributableFirmware
      ];
    };
    hostPlatform = {
      system = "x86_64-linux";
#       config = "x86_64-unknown-linux-gnu";
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  programs = {
    flashrom.enable = true;
    gnupg.agent.enable = true;
    light.enable = true;
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
#       synaptics.enable = true; # touchpad
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
  time.timeZone = "Asia/Bangkok";

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
#     virtualbox.host.enableExtensionPack = true;
  };
}
