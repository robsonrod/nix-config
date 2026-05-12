{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.waybar;
  timeout = 300;
in
{
  options.waybar = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.file = {
      ".config/waybar/config" = {
        source = "${vars.dotfiles}/waybar/.config/waybar/config";
      };

      ".config/waybar/style.css" = {
        source = "${vars.dotfiles}/waybar/.config/waybar/style.css";
      };

    };
  };
}
