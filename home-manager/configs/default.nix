{ config, pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./xdg.nix
    ./thunar.nix
  ];
}
