{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.tmuxinator;
in
{
  options.tmuxinator = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.tmuxinator ];
  };

}
