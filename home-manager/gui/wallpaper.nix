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
        url = "https://raw.githubusercontent.com/robsonrod/nix-config/refs/heads/main/dotfiles/wallpaper/.config/wallpaper/nature-valley-2.jpg";
        sha256 = "0rm065ag2mqaqlxdf78b94dhqw24xpq2ica8kvf7jd821p6aa7kx";
        ext = "jpg";
      in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
