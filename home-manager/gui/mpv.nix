{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.mpv;
in
{
  options.mpv = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      mpv = {
        enable = true;
        scripts = [
          pkgs.mpvScripts.mpris # Allow controlling using media keys
          pkgs.mpvScripts.mpv-cheatsheet-ng # Show some simple mappings on '?'
          pkgs.mpvScripts.uosc # Nicer UI
        ];
      };
    };
  };
}
