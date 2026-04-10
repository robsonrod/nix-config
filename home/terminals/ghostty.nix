{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.ghostty;
in
{
  options.ghostty = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Ghostty terminal";
    };

    fontSize = mkOption {
      type = types.int;
      default = 10;
      description = "Font size for Ghostty";
    };

    opacity = mkOption {
      type = types.float;
      default = 1.0;
      description = "Background opacity";
    };

    blur = mkOption {
      type = types.int;
      default = 18;
      description = "Background blur radius";
    };
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;

      settings = {
        # Theme
        theme = "catppuccin-macchiato";

        # Cursor
        cursor-style = "block";
        cursor-style-blink = false;

        # Shell integration tweaks
        shell-integration-features = "no-cursor";

        # Font
        font-family = "JetBrainsMono Nerd Font";
        font-size = cfg.fontSize;

        # Window appearance
        background-opacity = cfg.opacity;
        background-blur-radius = cfg.blur;
        window-theme = "dark";
        window-decoration = false;

        # Layout polish
        gtk-tabs-location = "hidden";
        window-padding-x = 10;
        window-padding-y = 10;

        # Optional niceties
        font-feature = "liga";
      };

      themes = {
        catppuccin-macchiato = {
          background = "24273a";
          foreground = "cad3f5";
          cursor-color = "f4dbd6";

          selection-background = "363a4f";
          selection-foreground = "cad3f5";

          palette = [
            "0=#494d64"
            "1=#ed8796"
            "2=#a6da95"
            "3=#eed49f"
            "4=#8aadf4"
            "5=#f5bde6"
            "6=#8bd5ca"
            "7=#b8c0e0"
            "8=#5b6078"
            "9=#ed8796"
            "10=#a6da95"
            "11=#eed49f"
            "12=#8aadf4"
            "13=#f5bde6"
            "14=#8bd5ca"
            "15=#a5adcb"
          ];
        };
      };
    };
  };
}
