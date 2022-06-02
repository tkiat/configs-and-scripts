{ specialArgs, ... }:
let
  p = "/home/${specialArgs.username}/configs-and-scripts/configs/nix/qubes-os";
in
{
  imports = [
    "${p}/common.nix"
    "${p}/personal.nix"
  ];
}
