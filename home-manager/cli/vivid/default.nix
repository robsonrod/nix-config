{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.vivid;
in {
  options.vivid = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.vivid = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
