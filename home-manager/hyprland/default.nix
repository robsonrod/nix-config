{ config, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprshot.nix
    ./hyprlock.nix
    ./wlogout.nix
    ./waybar.nix
  ];
}
