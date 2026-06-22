{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.hyprland;
in
{
  options.hyprland = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.file = {
      ".config/hypr/hyprland.lua" = {
        source = "${vars.dotfiles}/hypr/.config/hypr/hyprland.lua";
      };
    };
  };
}
