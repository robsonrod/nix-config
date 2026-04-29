{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.bluetooth;
in
{
  options.bluetooth = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.blueman-applet = {
      enable = true;
    };

    services.mpris-proxy = {
      enable = true;
    };
  };
}
