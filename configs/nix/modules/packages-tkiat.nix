{ config, pkgs, ... }:

let
  tkiat-channel = builtins.fetchGit {
    url = "https://gitlab.com/tkiat/nix-channel.git";
    rev = "23711771acc3d1c2405c39d67f02f29c5bf9f346";
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
