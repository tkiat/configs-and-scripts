{
  description = "template VM config";

#   TODO move these 21.11 to common-flake.nix
  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-21.11"; # also update stateVersion
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

#     pomodoro-bar.url = github:tkiat/pomodoro-bar/main;
#     pomodoro-bar-py.url = github:tkiat/pomodoro-bar-py/main;
#     tkiat-dmenu.url = gitlab:tkiat/forked-dmenu/my-config;
#     tkiat-dwm.url = gitlab:tkiat/forked-dwm/my-config;
#     tkiat-slock.url = gitlab:tkiat/forked-slock/my-config;
#     tkiat-st.url = gitlab:tkiat/forked-st/my-config;
  };

  outputs = { home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "user";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        # TODO include packages on template but only peronal data differs
#         configuration = import ./all.nix;
#         configuration = import ./dev.nix;

        inherit system username;
        homeDirectory = "/home/${username}";
        stateVersion = "21.11";

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
