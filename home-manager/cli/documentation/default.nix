{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.documentation;
in {
  options.documentation = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      man.enable = true;
      tealdeer.enable = true;
    };
  };

}
