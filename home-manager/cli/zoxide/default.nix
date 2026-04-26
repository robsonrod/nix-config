{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.zoxide;
in {
  options.zoxide = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
      enableZshIntegration = true;
    };
  };
}
