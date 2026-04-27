{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.fd;
in {
  options.fd = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.fd = {
      enable = true;
    };
  };
}
