{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.xresources;
in
{
  options.xresources = {

    enable = mkOption {
      type = bool;
      default = false;
    };

    dpi = mkOption {
      type = int;
      default = 200;
    };

    rofiDpi = mkOption {
      type = int;
      default = 250;
    };

  };

  config = mkIf cfg.enable {
    xresources = {
      properties = {

        "*background" = "#24273a";
        "*foreground" = "#cad3f5";
        "*cursorColor" = "#f4dbd6";

        "*color0" = "#494d64";
        "*color8" = "#5b6078";

        "*color1" = "#ed8796";
        "*color9" = "#ed8796";

        "*color2" = "#a6da95";
        "*color10" = "#a6da95";

        "*color3" = "#eed49f";
        "*color11" = "#eed49f";

        "*color4" = "#8aadf4";
        "*color12" = "#8aadf4";

        "*color5" = "#f5bde6";
        "*color13" = "#f5bde6";

        "*color6" = "#8bd5ca";
        "*color14" = "#8bd5ca";

        "*color7" = "#b8c0e0";
        "*color15" = "#a5adcb";

        "Xcursor.size" = 48;
        "Xcursor.theme" = "Adwaita";
        "Xft.dpi" = cfg.dpi;
        "rofi.dpi" = cfg.rofiDpi;

        "*.antialias" = "true";
        "*.hinting" = "true";
        "*.autohint" = "true";
        "Xft.hintstyle" = "hintslight";
        "Xft.rgba" = "rgb";
        "Xft.lcdfilter" = "lcddefault";
      };
    };
  };
}
