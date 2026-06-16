{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.alacritty;

  gruvboxMaterialHard = {
    primary = {
      background = "#1D2021";
      foreground = "#D4BE98";
    };

    normal = {
      black = "#1D2021";
      red = "#EA6962";
      green = "#A9B665";
      yellow = "#D8A657";
      blue = "#7DAEA3";
      magenta = "#D3869B";
      cyan = "#89B482";
      white = "#D4BE98";
    };

    bright = {
      black = "#665C54";
      red = "#EA6962";
      green = "#A9B665";
      yellow = "#D8A657";
      blue = "#7DAEA3";
      magenta = "#D3869B";
      cyan = "#89B482";
      white = "#F2E5BC";
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

          colors = gruvboxMaterialHard;

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
