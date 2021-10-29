{ config, pkgs, ... }:
let
  configs = [./config.conf ./status.conf];
in
{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" (map builtins.readFile configs);
  };
}
