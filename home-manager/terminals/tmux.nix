{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.tmux;
in
{
  options.tmux = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
    ];

    home.file = {
      ".config/tmux/tmux.conf" = {
        source = "${vars.dotfiles}/tmux/.config/tmux/tmux.conf";
      };
    };

  };

}

