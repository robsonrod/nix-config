{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.zathura;
in
{
  options.zathura = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      zathura.enable = true;
    };

    home.file = {
      ".config/zathura" = {
        source = "${vars.dotfiles}/zathura/.config/zathura";
        recursive = true;
      };

    };

  };

}
