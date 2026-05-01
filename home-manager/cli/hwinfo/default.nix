{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.hwinfo;
in {
  options.hwinfo = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hwinfo
      lshw
    ];

  };
}
