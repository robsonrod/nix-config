{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.foot;
in
{
  options.foot = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      foot = {
        enable = true;

        server.enable = true;

        settings = {
          main = {
            #term = "xterm-256color";

            font = "JetBrainsMono Nerd Font:size=6";
            dpi-aware = "yes";
          };

          mouse = {
            hide-when-typing = "yes";
          };

          colors-dark = {
            foreground = "CAD3F5";
            background = "24273A";

            regular0 = "494D64"; # surface1
            regular1 = "ED8796"; # red
            regular2 = "A6DA95"; # green
            regular3 = "EED49F"; # yellow
            regular4 = "8AADF4"; # blue
            regular5 = "F5BDE6"; # pink
            regular6 = "8BD5CA"; # teal
            regular7 = "B8C0E0"; # subtext1

            bright0 = "5B6078"; # surface2
            bright1 = "ED8796";
            bright2 = "A6DA95";
            bright3 = "EED49F";
            bright4 = "8AADF4";
            bright5 = "F5BDE6";
            bright6 = "8BD5CA";
            bright7 = "A5ADCB"; # subtext0

            selection-foreground = "CAD3F5";
            selection-background = "363A4F";

            search-box-no-match = "24273A F38BA8";
            search-box-match = "CAD3F5 363A4F";

            jump-labels = "24273A F5BDE6";
            urls = "8AADF4";
          };

          cursor = {
            blink = "yes";
            style = "block";
          };

          scrollback = {
            lines = 100000;
          };

          key-bindings = {
            show-urls-launch = "Control+Shift+o";
          };

          url-bindings = {
            cancel = "Control+g Control+c Control+d Escape";
            toggle-url-visible = "t";
          };

        };
      };

    };
  };

}
