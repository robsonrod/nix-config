{ config, pkgs, ... }:
{
  imports =
    [
      ./modules/boot.nix
      ./modules/network.nix
      ./modules/locale.nix
      ./modules/user.nix
      ./modules/basecli.nix
      ./modules/desktop.nix
      ./modules/audio.nix
      ./modules/bluetooth.nix
      ./modules/fingerprint.nix
      ./modules/nixconfig.nix
      ./modules/misc.nix
      ./modules/docker.nix
      ./modules/video/intel.nix
    ];
}
