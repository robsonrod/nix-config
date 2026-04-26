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
    catppuccin = {
      btop = {
        enable = true;
        flavor = "macchiato";
      };
    };

    programs.btop = {
      enable = true;
    };

  };
}
