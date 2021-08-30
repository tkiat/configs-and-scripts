{ config, pkgs, ... }:

let my-slock = import ./my-packages/tkiat-slock.nix;
in
{
  environment = {
    systemPackages =
      [
        my-slock
      ];
  };

  security.wrappers.slock.source = "${my-slock.out}/bin/slock";
}
