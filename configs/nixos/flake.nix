{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.st.url = "gitlab:tkiat/forked-st/my-config";

  outputs = { self, nixpkgs, st }: {

#     usage: sudo nixos-rebuild --impure switch --flake ~/configs-and-scripts/configs/nixos#nixos-main
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration/nixos-main.nix ];
    };
  };
}
