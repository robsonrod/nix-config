{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.fzf;
in {
  options.fzf = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
