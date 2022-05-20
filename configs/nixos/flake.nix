{
  inputs = {
    home-manager.url = github:nix-community/home-manager;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    pomodoro-bar.url = github:tkiat/pomodoro-bar/main;
    pomodoro-bar-py.url = github:tkiat/pomodoro-bar-py/main;
    tkiat-dmenu.url = gitlab:tkiat/forked-dmenu/my-config;
    tkiat-dwm.url = gitlab:tkiat/forked-dwm/my-config;
    tkiat-slock.url = gitlab:tkiat/forked-slock/my-config;
    tkiat-st.url = gitlab:tkiat/forked-st/my-config;
  };

  outputs = { home-manager, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos-main = nixpkgs.lib.nixosSystem {
      modules = [
        # machine specific
        ./configuration/machine/nixos-main.nix

        # system - shared
        ./configuration/system/shared.nix

        # system - shared packages
        ({ pkgs, ... }: {
          environment.systemPackages =
            (import ./configuration/system/shared-pkgs.nix pkgs).list
            ++ [
              inputs.pomodoro-bar.defaultPackage.x86_64-linux
              inputs.pomodoro-bar-py.defaultPackage.x86_64-linux
              inputs.tkiat-dmenu.defaultPackage.x86_64-linux
              inputs.tkiat-dwm.defaultPackage.x86_64-linux
              inputs.tkiat-slock.defaultPackage.x86_64-linux
              inputs.tkiat-st.defaultPackage.x86_64-linux
            ];

          security.wrappers.slock = {
            group = "root";
            owner = "root";
            setuid = true;
            source = "${inputs.tkiat-slock.defaultPackage.x86_64-linux.out}/bin/slock";
          };
        })

        # home manager
        home-manager.nixosModules.home-manager {
          home-manager.users.tkiat =
            import ./configuration/home-manager/tkiat.nix;
        }
      ];
    };
  };
}
           # add packages to `pkgs`
#            nixpkgs.overlays = [
#              (_: _: {
#                tkiat-st = tkiat-st.defaultPackage.x86_64-linux;
#              })
#            ];
