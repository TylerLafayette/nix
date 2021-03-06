{ config, pkgs, ... }:

let
  packages = with pkgs; [
    # Development
    ## Languages and compilers
    nodejs_latest
    yarn
    rustup
    go
    gopls
    ## Containers and virtualization
    qemu
    # Unfortunately, podman doesn't seem to work correctly from nixpkgs.
    # Currently using the brew version instead.
    # podman
    # podman-compose

    # Version control
    git

    # Productivity
    ripgrep
    silver-searcher
    thefuck

    # Utility
    htop
    tree
    xz
    gvproxy
  ];
in
{
  imports = builtins.map (x: ./modules + ("/" + x)) (builtins.attrNames (builtins.readDir ./modules));
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "tyler";
    homeDirectory = "/Users/tyler";
    sessionVariables = {
      EDITOR = "nvim";
    };
    
    packages = packages;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  nixpkgs.config.allowUnfree = true;
}
