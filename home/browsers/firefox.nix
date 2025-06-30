{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.firefox;
in
{
  options.firefox = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      firefox = {
        enable = true;
      };
    };

  };

}