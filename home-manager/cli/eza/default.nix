{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.eza;
in {
  options.eza = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    catppuccin = {
      eza = {
        enable = true;
        flavor = "macchiato";
      };
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };

  };
}
