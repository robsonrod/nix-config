{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.hyprshot;
in
{
  options.hyprshot = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.hyprshot = {
      enable = true;
    };
  };
}
