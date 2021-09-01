{ config, pkgs, ... }:

let
  pomodoro-px = import ./packages-custom/pomodoro-px.nix;
  tkiat-dwm = import ./packages-custom/tkiat-dwm.nix;
  tkiat-dmenu = import ./packages-custom/tkiat-dmenu.nix;
  tkiat-slock = import ./packages-custom/tkiat-slock.nix;
  tkiat-st = import ./packages-custom/tkiat-st.nix;
in
{
  environment.systemPackages = [
    pomodoro-px
    tkiat-dmenu
    tkiat-dwm
    tkiat-slock
    tkiat-st
  ];

  security.wrappers.slock.source = "${tkiat-slock.out}/bin/slock";
}
