{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.librewolf;
in
{
  options.librewolf = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      librewolf = {
        enable = true;
      };
    };

  };

}
