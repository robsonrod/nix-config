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
    programs.bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };

  };
}
