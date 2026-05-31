{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.direnv;
in {
  options.direnv = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      silent = true;
      config = {
        warn_timeout = "1m";
      };
    };

  };
}
