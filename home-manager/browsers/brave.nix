{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.brave-origin;
in
{
  options.brave-origin = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brave-origin
    ];

  };

}
