{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
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

  networking.hostName = "nixos-main";
  system.stateVersion = "21.11"; # README before modification
  users.users.tkiat = {
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "video" "wheel" ];
    uid = 1000;
  };
}
