{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.st.url = "gitlab:tkiat/forked-st/my-config";

  outputs = { self, nixpkgs, st }: {

    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration/nixos-main.nix ];
    };
  };
}
