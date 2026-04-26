{ config, options, lib, pkgs, vars, ... }:

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
    };

    home.file = {
      ".config/git" = {
        source = "${vars.dotfiles}/git/.config/git";
        recursive = true;
      };
    };
  };
}
