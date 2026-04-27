{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.cliapps;
in {
  options.cliapps = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      file
      grc
      hwinfo
      libnotify
      lshw
      vivid
      xdg-utils
      dysk
      vips
    ];

  };
}
