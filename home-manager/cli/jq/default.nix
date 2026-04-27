{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.jq;
in {
  options.jq = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.jq = {
      enable = true;
      colors = {
        null = "1;30";
        false = "0;37";
        true = "0;37";
        numbers = "0;37";
        strings = "0;32";
        arrays = "1;39";
        objects = "1;39";
        objectKeys = "1;34";
      };
    };
  };
}
