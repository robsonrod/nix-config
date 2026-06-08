{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.picom;
in
{
  options.picom = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;

      backend = "glx";
      vSync = true;

      settings = {

        # ======================
        # Shadows (very subtle)
        # ======================
        shadow = true;
        shadow-radius = 6;
        shadow-opacity = 0.25;
        shadow-offset-x = -4;
        shadow-offset-y = -4;

        shadow-exclude = [
          "class_g = 'Dunst'"
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];

        # ======================
        # Blur (soft + minimal)
        # ======================
        blur = {
          method = "dual_kawase";
          strength = 3;
          background = true;
          background-frame = false;
          background-fixed = false;
        };

        blurExclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];

        # ======================
        # Rounded corners
        # ======================
        corner-radius = 10;
        round-borders = 1;

        rounded-corners-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];

        # ======================
        # Opacity (Catppuccin feel)
        # ======================
        inactive-opacity = 0.92;
        active-opacity = 1.0;
        frame-opacity = 1.0;

        opacity-rule = [
          "88:class_g = 'rofi'"
          "90:class_g = 'kitty'"
          "90:class_g = 'Alacritty'"
          "90:class_g = 'foot'"
        ];

        # ======================
        # Behavior
        # ======================
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;

        use-damage = true;

        mark-wmwin-focused = true;
        mark-ovredir-focused = true;

        log-level = "warn";
      };

      wintypes = {
        tooltip = {
          fade = true;
          shadow = true;
          opacity = 0.95;
        };

        dock = {
          shadow = false;
        };

        dnd = {
          shadow = false;
        };

        popup_menu = {
          opacity = 0.95;
        };

        dropdown_menu = {
          opacity = 0.95;
        };
      };

    };
  };
}
