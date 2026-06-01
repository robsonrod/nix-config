{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.alacritty;

  catppuccinMacchiato = {
    primary = {
      background = "#24273A";
      foreground = "#CAD3F5";
    };
    normal = {
      black = "#24273A";
      red = "#F28FAD";
      green = "#ABE9B3";
      yellow = "#FAE3B0";
      blue = "#96CDFB";
      magenta = "#DDB6F2";
      cyan = "#B5E8E0";
      white = "#CAD3F5";
    };
    bright = {
      black = "#6E6C7E";
      red = "#F28FAD";
      green = "#ABE9B3";
      yellow = "#FAE3B0";
      blue = "#96CDFB";
      magenta = "#DDB6F2";
      cyan = "#B5E8E0";
      white = "#FFFFFF";
    };
  };

in
{
  options.alacritty = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      alacritty = {
        enable = true;

        settings = {
          font = {
            normal = {
              family = "JetBrains Mono Nerd Font";
              style = "Regular";
            };
            bold = {
              family = "JetBrains Mono Nerd Font";
              style = "Bold";
            };
            italic = {
              family = "JetBrains Mono Nerd Font";
              style = "Italic";
            };
            size = 10.0;
          };

          colors = catppuccinMacchiato;

          cursor = {
            style = {
              shape = "Block";
              blinking = "On";
            };
          };

          scrolling = {
            history = 10000;
            multiplier = 3;
          };

        };


      };
    };
  };

}
