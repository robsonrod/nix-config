{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.nh;
in
{
  options.nh = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    programs.nh = {
      enable = true;
      #    clean.enable = true;
      #    clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${vars.user}/nix-config";
    };

  };
}
