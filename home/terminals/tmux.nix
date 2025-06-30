{ config, options, lib, pkgs, ... }:

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
    programs = {
      tmux = {
        enable = true;
      };
    };

  };

}
