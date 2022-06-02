{
  description = "work qube";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    pomodoro-bar.url = github:tkiat/pomodoro-bar/main;
    pomodoro-bar-py.url = github:tkiat/pomodoro-bar-py/main;
    tkiat-st.url = gitlab:tkiat/forked-st/my-config;
  };

  outputs = { home-manager, pomodoro-bar, pomodoro-bar-py, tkiat-st, ... }:
    let
      system = "x86_64-linux";
      username = "user";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username;
        configuration = import ./config.nix;
        extraSpecialArgs = {
          inherit username;
          pomodoro-bar = pomodoro-bar.defaultPackage.${system};
          pomodoro-bar-py = pomodoro-bar-py.defaultPackage.${system};
          tkiat-st = tkiat-st.defaultPackage.${system};
        };
        homeDirectory = "/home/${username}";
        stateVersion = "21.11";
      };
    };
}
