{ lib, pkgs, specialArgs, ... }:

let
  my-config = "/home/${specialArgs.username}/configs-and-scripts/configs";
in
{
  programs = {
    chromium = {
      enable = true;
      extensions = [
        { id = "lhdoppojpmngadmnindnejefpokejbdd"; } # axe devtools
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
        { id = "ammoloihpcbognfddfjcljgembpibcmb"; } # javascript restrictor
        { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # react devtools
        { id = "npadhaijchjemiifipabpmeebeelbmpd"; } # theme - material dark
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
        { id = "cdockenadnadldjbbgcallicgledbeoc"; } # visBug
      ];
      package = pkgs.chromium;
    };
  };

  home = {
    file = {
      ".newsboat/config".source = "${my-config}/newsboat/config";
      ".newsboat/urls".source = "${my-config}/newsboat/urls";
    };

    packages = with pkgs; [
      newsboat
      tor-browser-bundle-bin
      vlc
    ];
  };
}
