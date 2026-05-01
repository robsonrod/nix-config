{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.grc;
in {
  options.grc = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grc
    ];

  };
}
