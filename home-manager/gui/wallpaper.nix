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
        url = "https://raw.githubusercontent.com/AngelJumbo/gruvbox-wallpapers/refs/heads/main/wallpapers/photography/forest-2.jpg";
        sha256 = "0lihk9kc1givn4fl3bhrjwizssplfpqnh826xha9jvzqg45c5b26";
        ext = "jpg";
      in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
