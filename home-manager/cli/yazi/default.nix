{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.yazi;
in {
  options.yazi = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    catppuccin = {
      yazi = {
        enable = true;
        flavor = "macchiato";
        accent = "blue";
      };
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };

  };
}
