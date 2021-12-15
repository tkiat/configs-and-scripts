{ lib, ... }:

{
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "google-chrome"
        "unrar"
      ];
      blacklistedLicenses = with lib.licenses; [
        # NixOS doesn't treat unfreeRedistributableFirmware as unfree
        unfreeRedistributableFirmware
      ];
    };
  };
}
