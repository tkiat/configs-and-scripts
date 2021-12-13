{ pkgs, ... }:
let
  myGhc = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    lens
    mtl
    transformers
  ]);
in
{
  environment = {
    systemPackages = with pkgs; [ myGhc ];
  };
}
