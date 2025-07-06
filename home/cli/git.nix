{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.git;
in {
  options.git = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      delta
    ];

    programs.git = {
      enable = true;
      userName = "Robson Rodrigues";
      userEmail = "robsonrod@gmail.com";
    };
  };
}
