{ ... }:

let
  tkiat-channel = builtins.fetchGit {
    url = "https://gitlab.com/tkiat/nix-channel.git";
    ref = "main";
    rev = "0ce37bef4ba5fee5eccd94310add25673bc89ce9";
  };

  #   pomodoro-px = import "${tkiat-channel}/packages/pomodoro-px.nix";
  tkiat-dmenu = import "${tkiat-channel}/packages/tkiat-dmenu.nix";
  tkiat-dwm = import "${tkiat-channel}/packages/tkiat-dwm.nix";
  tkiat-slock = import "${tkiat-channel}/packages/tkiat-slock.nix";
#   tkiat-st = import "${tkiat-channel}/packages/tkiat-st.nix";
in
{
  environment.systemPackages = [
    #     pomodoro-px
    tkiat-dmenu
    tkiat-dwm
    tkiat-slock
#     tkiat-st
  ];

  security.wrappers.slock = {
    group = "root";
    owner = "root";
    setuid = true;
    source = "${tkiat-slock.out}/bin/slock";
  };
}
