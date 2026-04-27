{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.calibre;
in
{
  options.calibre = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      calibre = {
        enable = true;
      };
    };
  };
}
