{ config, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprshot.nix
    ./wlogout.nix
  ];
}
