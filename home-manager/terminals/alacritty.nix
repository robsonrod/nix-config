{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.alacritty;
in
{
  options.alacritty = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    catppuccin.alacritty = {
      enable = true;
      flavor = "macchiato";
    };

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
