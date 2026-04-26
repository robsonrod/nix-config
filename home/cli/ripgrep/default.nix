{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.ripgrep;
in {
  options.ripgrep = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
      arguments = [ "--hidden" ];
    };
  };
}
