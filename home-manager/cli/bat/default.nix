{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.bat;
in {
  options.bat = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    catppuccin = {
      bat = {
        enable = true;
        flavor = "macchiato";
      };
    };

    programs.bat = {
      enable = true;
    };

  };
}
