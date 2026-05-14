{ config, pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./thunar.nix
  ];
}
