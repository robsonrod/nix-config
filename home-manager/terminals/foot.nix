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
            alpha = 0.9;
            foreground = "ebdbb2";
            background = "282828";

            regular0 = "282828";
            regular1 = "cc241d";
            regular2 = "98971a";
            regular3 = "d79921";
            regular4 = "458588";
            regular5 = "b16286";
            regular6 = "689d6a";
            regular7 = "a89984";

            bright0 = "928374";
            bright1 = "fb4934";
            bright2 = "b8bb26";
            bright3 = "fabd2f";
            bright4 = "83a598";
            bright5 = "d3869b";
            bright6 = "8ec07c";
            bright7 = "ebdbb2";

            selection-foreground = "282828";
            selection-background = "ebdbb2";

            search-box-no-match = "282828 cc241d";
            search-box-match = "ebdbb2 928374";

            jump-labels = "282828 fabd2f";
            urls = "83a598";
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
