{
  description = "untrusted qube";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    tkiat-st.url = gitlab:tkiat/forked-st/my-config;
  };

  outputs = { home-manager, tkiat-st, ... }:
    let
      system = "x86_64-linux";
      username = "user";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username;
        configuration = import ./components.nix;
        extraSpecialArgs = {
          inherit username;
          tkiat-st = tkiat-st.defaultPackage.${system};
        };
        homeDirectory = "/home/${username}";
        stateVersion = "21.11";
      };
    };
}
