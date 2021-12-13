{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

#     usage: sudo nixos-rebuild --impure switch --flake ~/configs-and-scripts/configs/nixos#nixos-main
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration-nixos-main.nix ];
    };

  };
}
