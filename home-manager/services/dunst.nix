{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.dunst;
in
{
  options.dunst = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          follow = "mouse";

          width = 320;
          offset = "15x15";
          origin = "top-right";

          padding = 12;
          horizontal_padding = 12;

          frame_width = 2;
          corner_radius = 12;

          font = "FiraCode Nerd Font Mono 10";

          format = "%s\n%b";

          stack_duplicates = true;

          mouse_left_click = "close_current";
          mouse_right_click = "close_all";
        };

        urgency_low = {
          background = "#24273a";
          foreground = "#a5adcb";
          timeout = 5;
        };

        urgency_normal = {
          background = "#24273a";
          foreground = "#cad3f5";
          timeout = 10;
        };

        urgency_critical = {
          background = "#24273a";
          foreground = "#cad3f5";
          frame_color = "#f5a97f";
          timeout = 0;
        };
      };
    };
  };
}
