{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.neovim;
in
{
  options.neovim = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      neovim = {
        enable = true;
	vimAlias = true;
      };
    };

  };

}