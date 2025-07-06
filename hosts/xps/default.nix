{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../configuration
    ];

  hostname.hostname = "xps";
  fingerprint.enable = true;
  intel.enable = true;
  keyboard.kbdLayout = "br";
}
