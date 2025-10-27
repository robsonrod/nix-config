{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.intel;
in {
  options.intel = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
      };

    };

    services.xserver = {
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';
    };
  };
}
