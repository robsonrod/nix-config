{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.anki;
in
{
  options.anki = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      anki = {
        enable = true;
        addons = with pkgs; [
          ankiAddons.passfail2
        ];
      };
    };
  };

}
