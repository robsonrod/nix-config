{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.sioyek;
in
{
  options.sioyek = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      sioyek = {
        enable = true;

        config = {
          background_color = "1.0 1.0 1.0";
          text_highlight_color = "1.0 0.0 0.0";
          startup_commands = [
            "toggle_visual_scroll"
            "toggle_dark_mode"
          ];
        };

        bindings = {
          move_up = "k";
          move_down = "j";
          move_left = "h";
          move_right = "l";
          screen_down = [ "d" "<c-d>" ];
          screen_up = [ "u" "<c-u>" ];
        };
      };
    };
  };

}
