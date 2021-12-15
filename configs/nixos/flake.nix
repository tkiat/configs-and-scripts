{
  inputs = {
    home-manager.url = github:nix-community/home-manager;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    tkiat-custom-st.url = gitlab:tkiat/forked-st/my-config;
  }

  outputs = { self, home-manager, nixpkgs, tkiat-custom-st }:
#     let
#        overlays = self: super: {
#          tkiat-custom-st = nixpkgs.legacyPackages.${"x86_64-linux"}.callPackage tkiat-custom-st {};
#        };
#        nixpkgs.overlays = [ overlays ];
#     in
    {
      nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration/nixos-main.nix
          home-manager.nixosModules.home-manager {
            home-manager.users.tkiat = import ./configuration/shared/home-manager-tkiat.nix;
          }
#             home-manager.useGlobalPkgs = true;
#             home-manager.useUserPackages = true;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
# #          tkiat-custom-st = tkiat-custom-st;
#           { nixpkgs.overlays = [ tkiat-custom-st ]; }
  #         {inherit tkiat-custom-st; }
        ];
      };
    };
}
