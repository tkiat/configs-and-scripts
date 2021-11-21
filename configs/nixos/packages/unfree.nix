{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "google-chrome"
  ];
  environment = {
    systemPackages =
      with pkgs;
      [
        google-chrome
      ];
  };
}
