{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.hyprpaper;
in {
  options.hyprpaper = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      importantPrefixes = [ "monitor" ];

      settings = {
        splash = false;
        ipc = "on";

        wallpaper = [
          {
            monitor = "eDP-1";
            path = config.wallpaper;
            fit_mode = "fill";
          }
        ];
      };

    };

  };
}
