{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.zathura;
in
{
  options.zathura = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      zathura.enable = true;
   };
   
  };

}