{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.udiskie;
in {
  options.udiskie = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      automount = false;
    };
  };
}
