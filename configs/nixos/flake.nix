{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.nur.url = github:nix-community/NUR;
  inputs.st.url = gitlab:tkiat/forked-st/my-config;

  outputs = { self, nixpkgs, nur, st }: {

    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [
        { nixpkgs.overlays = [ nur.overlay ]; }
        ./configuration/nixos-main.nix
      ];
    };
  };
}
