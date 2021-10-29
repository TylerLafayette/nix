{ config, lib, pkgs, ... }:
let
  plugins = with pkgs.vimPlugins; [
    # Appearance
    ## Colorscheme
    iceberg-vim

    # Completions and LSP support
    coc-nvim

    # Behavior extensions
    ## Automatic tab width detection
    vim-sleuth
    ## Fuzzy finding
    fzf-vim

    # Language-specific plugins
    ## Language support
    vim-nix
    rust-vim
    vim-go
    typescript-vim

    # Utils
    vim-gitbranch
  ];
  extraConfigs = [./config.vim ./keybinds.vim ./statusline.vim];
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = plugins;
    extraConfig = builtins.concatStringsSep "\n" (builtins.map builtins.readFile extraConfigs); 
  };
}
