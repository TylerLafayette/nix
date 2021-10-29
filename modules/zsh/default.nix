{ config, lib, pkgs, ... }:
let
  zshTheme = ''
    source ${./theme.zsh_theme}
  '';
  configs = ''
    echo "welcome, $(whoami)\n" | ${pkgs.lolcat}/bin/lolcat

    # Source home secrets
    source $HOME/.secrets.env

    export TERM=xterm-256color

    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6b7089"
    export ZSH_AUTOSUGGEST_STRATEGY="completion"
    export ZSH_AUTOSUGGEST_USE_ASYNC="yes"

    # TODO: not do this, idk why this is necessary
    source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

    # This is so sad
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';
  functions = ''
    # Convenience function to open home.nix.
    home() {
      vim ~/.config/nixpkgs/home.nix
    }
    # Convenience function to open a default.nix for a specified module.
    module() {
      vim ~/.config/nixpkgs/modules/"$1"/default.nix
    }
  '';
in
{
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    tmux = {
      enable = true;
    };

    zsh = let
      mkZshPlugin = { pkg, file ? "${pkg.name}.plugin.zsh" }: rec {
        name = pkg.pname;
        src = pkg.src;
        inherit file;
      };
    in
    {
      enable = true;
      plugins = with pkgs; [
        (mkZshPlugin { pkg = zsh-autosuggestions; })
        (mkZshPlugin {
          pkg = zsh-fzf-tab;
          file = "fzf-tab.plugin.zsh";
        })
        (mkZshPlugin { pkg = zsh-syntax-highlighting; })
      ];

      initExtra = builtins.concatStringsSep "\n" [zshTheme configs functions];

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "cypher";
      };
    };
  };
}
