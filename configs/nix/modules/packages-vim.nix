{ config, pkgs, ... }:

{
  environment = {
    systemPackages =
      with pkgs;
      [
        vim

        (neovim.override {
          configure = {
            customRC = ''
              let initial_file = "/home/".$USER."/.config/nvim/init.vim"
              if filereadable(initial_file)
                exec "source ".initial_file
              endif
            '';
            packages.myVimPackage = with pkgs.vimPlugins;
              {
                start = [
                  completion-nvim
                  dhall-vim
                  emmet-vim
                  nerdtree
                  nvim-lspconfig
                  nvim-treesitter
                  purescript-vim
                  vim-nix
                  vim-toml
                ];
                # manual `:packadd $plugin-name`
                opt = [ ];
                # To automatically load a plugin when opening a filetype, add vimrc lines like:
                # autocmd FileType php :packadd phpCompletion
              };
          };
        })
      ];
  };
}
