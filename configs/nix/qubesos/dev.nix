{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [                               1
      htop
      fortune
    ];
  };

#   programs.home-manager.enable = true;
}
