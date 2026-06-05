{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.zathura;
in
{
  options.zathura = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      zathura = {
        enable = true;
        options = {
          "window-title-home-tilde" = true;
          "statusbar-home-tilde" = true;
          "sandbox" = "none";
          "statusbar-h-padding" = 0;
          "statusbar-v-padding" = 0;
          "page-padding" = 1;
          "selection-clipboard" = "clipboard";
        };
      };
    };
  };

}
