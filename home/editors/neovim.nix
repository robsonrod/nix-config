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
      lua-language-server
      stylua
      nixd
      nil
      gopls
    ];

    programs = {
      neovim = {
        enable = true;
        vimAlias = true;
        vimdiffAlias = true;
        extraPackages = with pkgs; [
          pkgs.lua5_1
          pkgs.luajit
          pkgs.luarocks
          pkgs.nil
        ];
      };
    };

  };

}
