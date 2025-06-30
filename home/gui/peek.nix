{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.peek;
in
{
  options.peek = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      peek
    ];
  };

}
