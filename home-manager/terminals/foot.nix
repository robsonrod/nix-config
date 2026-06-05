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
            foreground = "d4be98";
            background = "1d2021";

            regular0 = "1d2021";
            regular1 = "ea6962";
            regular2 = "a9b665";
            regular3 = "d8a657";
            regular4 = "7daea3";
            regular5 = "d3869b";
            regular6 = "89b482";
            regular7 = "d4be98";

            bright0 = "928374";
            bright1 = "ea6962";
            bright2 = "a9b665";
            bright3 = "d8a657";
            bright4 = "7daea3";
            bright5 = "d3869b";
            bright6 = "89b482";
            bright7 = "ddc7a1";

            selection-foreground = "1d2021";
            selection-background = "d4be98";

            search-box-no-match = "1d2021 ea6962";
            search-box-match = "d4be98 928374";

            jump-labels = "1d2021 d8a657";
            urls = "7daea3";
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
