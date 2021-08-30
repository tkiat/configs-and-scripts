{ config, pkgs, ... }:

let
  tkiat-slock = import ./my-packages/tkiat-slock.nix;
  tkiat-st = import ./my-packages/tkiat-st.nix;
in
{
  environment.systemPackages = [
    tkiat-slock
    tkiat-st
  ];

  security.wrappers.slock.source = "${tkiat-slock.out}/bin/slock";
}
