{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };

  };
}
