{ config, pkgs, ... }:
{
  imports =
    [
      ./modules/boot.nix
      ./modules/intel.nix
      ./modules/network.nix
      ./modules/locale.nix
      ./modules/user.nix
      ./modules/basecli.nix
      ./modules/gnome.nix
      ./modules/audio.nix
      ./modules/bluetooth.nix
      ./modules/fingerprint.nix
      ./modules/security.nix
      ./modules/nixconfig.nix
      ./modules/misc.nix
      ./modules/keyboard.nix
      ./modules/video/intel.nix
      ./modules/nh.nix
    ];
}
