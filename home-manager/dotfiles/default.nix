{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.dotfiles;
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  dotfilesDir = "${config.home.homeDirectory}/nix-config/dotfiles";
in
{
  options.dotfiles = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.file = {
      ".config/nvim" = {
        recursive = true;
        source = mkOutOfStoreSymlink "${dotfilesDir}/nvim";
      };
    };
  };
}
