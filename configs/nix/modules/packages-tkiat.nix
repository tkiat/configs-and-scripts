{ config, pkgs, ... }:

let
  tkiat-channel = builtins.fetchGit {
    url = "https://gitlab.com/tkiat/nix-channel.git";
    rev = "ee93e5c8633965bcb7a8e0157470f3bee635f6db";
  };

  pomodoro-px = import "${tkiat-channel}/packages/pomodoro-px.nix";
  tkiat-dmenu = import "${tkiat-channel}/packages/tkiat-dmenu.nix";
  tkiat-dwm = import "${tkiat-channel}/packages/tkiat-dwm.nix";
  tkiat-slock = import "${tkiat-channel}/packages/tkiat-slock.nix";
  tkiat-st = import "${tkiat-channel}/packages/tkiat-st.nix";
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
