{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.xdgconfig;
in {
  options.xdgconfig = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-utils
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
}
