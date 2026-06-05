{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.btop;
in {
  options.btop = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark";
      };
    };

  };
}
