{ lib, pkgs, specialArgs, ... }:

let
  my-config = "/home/${specialArgs.username}/configs-and-scripts/configs";
in
{
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "unrar"
      ];
    };
  };
  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
      ''; # non-interactive shell
      initExtra = '' # interactive shell
        . ${my-config}/bash/.bashrc.shared
        . ${my-config}/alias/shared.alias
        . ${my-config}/alias/modules/nix.alias
        # . ${my-config}/alias/modules/nixos.alias
        . ${my-config}/alias/modules/systemctl.alias

        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        export QUBES_GPG_DOMAIN=my-vault

        # SPLIT SSH CONFIGURATION >>>
        # replace "vault" with your AppVM name which stores the ssh private key(s)
        SSH_VAULT_VM="vault"

        if [ "$SSH_VAULT_VM" != "" ]; then
          export SSH_AUTH_SOCK="/home/user/.SSH_AGENT_$SSH_VAULT_VM"
        fi
        # <<< SPLIT SSH CONFIGURATION
      '';
      profileExtra = ''
        # if running bash
        if [ -n "$BASH_VERSION" ]; then
            # include .bashrc if it exists
            if [ -f "$HOME/.bashrc" ]; then
          . "$HOME/.bashrc"
            fi
        fi

        # set PATH so it includes user's private bin if it exists
        if [ -d "$HOME/bin" ] ; then
            PATH="$HOME/bin:$PATH"
        fi

        # set PATH so it includes user's private bin if it exists
        if [ -d "$HOME/.local/bin" ] ; then
            PATH="$HOME/.local/bin:$PATH"
        fi

        if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
      '';
      shellOptions =  [ ];
    };
    git = {
      enable = true;
      aliases = {
        ch = "checkout";
        co = "commit";
        st = "status";
        pu = "push";
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
      userName  = "tkiat";
      userEmail = "tkiat@tutanota.com";
    };
    home-manager.enable = true;
    neovim = {
      enable = true;
      extraConfig = ''
        let mapleader=','
        let s:root_dir="${my-config}/neovim/init"

        exe "source ".s:root_dir."/shared.vim"

        exe "source ".s:root_dir."/colorscheme.vim"
        exe "source ".s:root_dir."/comment.vim"
        exe "source ".s:root_dir."/completion.vim"
        exe "source ".s:root_dir."/html.vim"
        exe "source ".s:root_dir."/plugin.vim"
        exe "source ".s:root_dir."/syntax.vim"
        exe "source ".s:root_dir."/template.vim"

        exe "luafile ".s:root_dir."/lsp.lua"
      '';
      plugins = with pkgs.vimPlugins; [
        completion-nvim
        dhall-vim
        emmet-vim
#         fugitive
        nerdtree
        nvim-lspconfig
        nvim-treesitter
        purescript-vim
        vim-nix
        vim-toml
      ];
    };
  };

#   noob = {pkgs, ...}: { home.packages = [ pkgs.fortune ]; };
  home = {
    enableNixpkgsReleaseCheck = true;

    file = {
      ".config/xmobar/.xmobarrc".source = "${my-config}/xmobar/.xmobarrc";
      ".local/share/fonts/comic shanns 2.ttf".source = "${my-config}/font/comic-shanns/v2/comic shanns 2.ttf";
      ".inputrc".text = ''
        set completion-ignore-case on
      '';
      ".config/polybar/config.ini".source = "${my-config}/polybar/config.ini";
      ".xinitrc".source = "${my-config}/xorg/.xinitrc";
      ".xmonad/xmonad.hs".source = "${my-config}/xmonad/xmonad.hs";
      ".xpdfrc".source = "${my-config}/xpdf/.xpdfrc";
      ".Xresources".source = "${my-config}/xorg/.Xresources";
    };

    packages = with pkgs; [
      # unfree
      unrar

      bat
      calc
      curl
      dejsonlz4
      dmidecode
      du-dust
      edid-decode
      exa
      exfat
      fd
      feh
      flashrom
      gnome.gedit
      gnome.zenity
      gnupg
      gwenview
      heimdall
      htop
      imagemagick
      jpegoptim
      killall
      less
      lm_sensors
      loc
      lshw
      mc
      mediainfo
      mupdf
      neofetch
      okular
      pandoc
      pciutils
#       pinentry
      pinta
      qview
      ranger
      ripgrep
      scrot
      smartmontools
      specialArgs.tkiat-st
      tealdeer
      tmux
      trash-cli
      unzip
      usbutils
      w3m
      wget
      xclip
      xfce.exo
      xfce.xfconf
      xsel
      xterm
      zip
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
