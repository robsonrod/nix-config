{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.urxvt;
in
{
  options.urxvt = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      urxvt = {
        enable = true;
      };
    };

  };

}