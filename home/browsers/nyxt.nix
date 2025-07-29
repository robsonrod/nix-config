{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.nyxt;
in
{
  options.nyxt = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      nyxt = {
        enable = true;
      };
    };

  };

}
