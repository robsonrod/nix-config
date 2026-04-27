{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.hstr;
in {
  options.hstr = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.hstr = {
      enable = true;
    };
  };
}
