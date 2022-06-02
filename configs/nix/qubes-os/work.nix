{ lib, pkgs, specialArgs, ... }:

let
  my-config = "/home/${specialArgs.username}/configs-and-scripts/configs";
  ghc' = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    lens
    mtl
    random
    transformers
  ]);
in
{
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "google-chrome"
      ];
    };
  };
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      # extensions = [ pkgs.vscode-extensions.bbenoist.Nix ];
      # haskell = {
      #   enable = true;
            # };
      # userSettings = {
      #   "update.channel" = "none";
            #   "[nix]"."editor.tabSize" = 2;
      # };
    };
  };

  home = {
    file = {
      # ".local/share/pomodoro-bar/record.json".source = config.lib.file.mkOutOfStoreSymlink "${my-cloud}/app/pomodoro-bar/record.json";
    };

    packages = with pkgs; [
      # unfree
      google-chrome

      # dev
      ansible
      cabal-install
      cookiecutter
      dash
      docker
      docker-compose
      gcc
      ghc'
      gnumake
      go
      graphviz
      jq
      kdenlive
      libreoffice
      lua
      niv
      nix-prefetch-git
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      python3
      sass
      shellcheck
      stack
      texlive.combined.scheme-full
      tokei
      yarn

      ghostscript
      gimp
      inkscape
      kdenlive
      libreoffice
      pencil
      simplescreenrecorder

      specialArgs.pomodoro-bar
      specialArgs.pomodoro-bar-py
    ];
  };
}
