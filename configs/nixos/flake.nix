{
  inputs = {
    home-manager.url = github:nix-community/home-manager;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    tkiat-custom-st.url = gitlab:tkiat/forked-st/my-config;
  };

  outputs = { self, home-manager, nixpkgs, tkiat-custom-st }: {
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration/nixos-main.nix
        ./configuration/shared/system-nixpkgs.nix
        home-manager.nixosModules.home-manager {
          home-manager.users.tkiat = import ./configuration/shared/home-manager-tkiat.nix;
        }
        ({ pkgs, ... }: {
           # Adding the package to `nixpkgs.overlays`. This means that when we use `pkgs` the package will be added to it. Overlay function takes two arguments: `final` and `prev`. We do not need these for this case as we are not overriding something that exists we are adding something new, so I used `_` for those. I am creating a new package called `tkiat-custom-st` and setting that equal to the flake's defaultPackage. I did this because this flake only defines a defaultPackage (it should define an overlay, and a package)
           nixpkgs.overlays = [
             (_: _: { tkiat-custom-st = tkiat-custom-st; })
           ];

           environment.systemPackages = import ./configuration/shared/noob.nix;
#              [ pkgs.tkiat-custom-st ];
         })
      ];
    };
  };
}
