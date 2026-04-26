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
        url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/landscapes/tropic_island_morning.jpg";
        sha256 = "1wvg1mqs391wrvrd2vxwxv11lwz2fq4pmlgmz2p237k456v4gwxz";
        ext = "jpg";
      in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
