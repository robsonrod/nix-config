{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.emacs;
  emacsPackage = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs: [ epkgs.vterm ]);
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
        package = emacsPackage;
      };
    };

  };

}