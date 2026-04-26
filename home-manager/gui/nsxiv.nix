{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.nsxiv;
in
{
  options.nsxiv = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nsxiv
    ];
  };

}
