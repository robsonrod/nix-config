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
        url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/os/windows-black.png";
        sha256 = "14qq1gwiyqz9pvasj9zz27fszvz8asq8jpk71lyml6lvinjgnhl1";
        ext = "png";
      in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
