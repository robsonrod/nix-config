{ config, pkgs, ... }:
{
  imports = [
    ./bat
    ./btop
    ./eza
    ./fastfetch
    ./git
    ./networkmanager-dmenu
    ./ripgrep
    ./starship
    ./yazi
    ./zoxide
    ./zsh
    ./cliapps.nix
  ];

}
