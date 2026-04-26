{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.emacs;
in
{
  options.emacs = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      emacs = {
        enable = true;
        package = pkgs.emacs;
        extraPackages = epkgs: [
          epkgs.vterm
        ];
      };
    };

  };

}
