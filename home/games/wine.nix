{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.wine;
in
{
  options.wine = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    wineWowPackages.staging
    winetricks
  ];
  };

}
