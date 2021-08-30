{ config, pkgs, ... }:

let
  tkiat-dwm = import ./my-packages/tkiat-dwm.nix;
  tkiat-dmenu = import ./my-packages/tkiat-dmenu.nix;
  tkiat-slock = import ./my-packages/tkiat-slock.nix;
  tkiat-st = import ./my-packages/tkiat-st.nix;
in
{
  environment.systemPackages = [
    tkiat-dmenu
    tkiat-dwm
    tkiat-slock
    tkiat-st
  ];

  security.wrappers.slock.source = "${tkiat-slock.out}/bin/slock";
}
