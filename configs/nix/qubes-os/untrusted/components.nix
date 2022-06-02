{ specialArgs, ... }:
{
  imports = [
    /home/${specialArgs.username}/configs-and-scripts/configs/nix/qubes-os/common.nix
    /home/${specialArgs.username}/configs-and-scripts/configs/nix/qubes-os/untrusted.nix
  ];
}
