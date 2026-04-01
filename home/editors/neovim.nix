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
    home.packages = with pkgs; [
      lua51Packages.lua
      lua51Packages.fennel
      lua51Packages.luarocks
      lua51Packages.luafilesystem
    ];
    programs = {
      neovim = {
        enable = true;
        vimAlias = true;
	vimdiffAlias = true;
      };
    };

  };

}
