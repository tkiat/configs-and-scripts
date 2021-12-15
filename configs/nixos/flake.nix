{
  inputs = {
    home-manager.url = github:nix-community/home-manager;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    tkiat-st.url = gitlab:tkiat/forked-st/my-config;
  };

  outputs = { self, home-manager, nixpkgs, tkiat-st }@inputs: {
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration/machine/nixos-main.nix
        ./configuration/system/shared.nix

        home-manager.nixosModules.home-manager {
          home-manager.users.tkiat =
            import ./configuration/home-manager/tkiat.nix;
        }

        ({ pkgs, ... }: {
          environment.systemPackages =
            (import ./configuration/system/shared-pkgs.nix pkgs).list
            ++ [
              inputs.tkiat-st.defaultPackage.x86_64-linux
            ];
        })
      ];
    };
  };
}
           # add packages to `pkgs`
#            nixpkgs.overlays = [
#              (_: _: {
#                tkiat-st = tkiat-st.defaultPackage.x86_64-linux;
#              })
#            ];
