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

    # Vim mode
    MODE_CURSOR_VIINS="#00ff00 blinking bar"
    MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
    MODE_CURSOR_VICMD="green block"
    MODE_CURSOR_SEARCH="#ff00ff steady underline"
    MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
    MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
    KEYTIMEOUT=5
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
  aliases = {
    docker = "podman";
    # Pretty-print tree excluding generated directories
    list = "tree -L 2 -C -I 'node_modules|vendor|build|target'";
  };
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
        {
          name = "zsh-vim-mode";
          src = fetchFromGitHub {
            owner = "softmoth";
            repo = "zsh-vim-mode";
            rev = "1f9953b7d6f2f0a8d2cb8e8977baa48278a31eab";
            sha256 = "1i79rrv22mxpk3i9i1b9ykpx8b4w93z2avck893wvmaqqic89vkb";
          };
        }
      ];

      initExtra = builtins.concatStringsSep "\n" [zshTheme configs functions];

      shellAliases = aliases;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "cypher";
      };
    };
  };
}
