{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.google-chrome;
in
{
  options.google-chrome = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      google-chrome = {
        enable = true;
      };
    };

  };

}
