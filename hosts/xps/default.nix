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
  keyboard = {
    kbdLayout = "br";
    kbdConsole = "br-abnt2";
  };
  nh.enable = true;
  vpn.enable = true;
}
