{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.kitty;
in
{
  options.kitty = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      kitty = {
        enable = true;
      };
    };
  };

}
