{ config, pkgs, ... }:

let
  tkiat-dwm = import ./packages-custom/tkiat-dwm.nix;
  tkiat-dmenu = import ./packages-custom/tkiat-dmenu.nix;
  tkiat-slock = import ./packages-custom/tkiat-slock.nix;
  tkiat-st = import ./packages-custom/tkiat-st.nix;
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
