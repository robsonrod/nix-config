{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.wallpaper;
in
{
  options.wallpaper = mkOption {
    description = ''
      Location of the wallpaper to use throughout the system.
    '';
    type = lib.types.path;
    example = lib.literalExample "./wallpaper.png";
  };

  config = {
    wallpaper =
      let
        url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/misc/cat_pacman.png";
        sha256 = "16n3azhmqqjgj4jmsf0g0v3v0zmgh8kll876c17an95pqah2hlsr";
        ext = "png";
      in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
