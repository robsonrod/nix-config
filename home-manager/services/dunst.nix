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
          background = "#1d2021";
          foreground = "#a89984";
          timeout = 5;
        };

        urgency_normal = {
          background = "#1d2021";
          foreground = "#ebdbb2";
          timeout = 10;
        };

        urgency_critical = {
          background = "#1d2021";
          foreground = "#ebdbb2";
          frame_color = "#cc241d";
          timeout = 0;
        };
      };
    };
  };
}
