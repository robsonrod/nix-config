{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../configuration
    ];

  hostname.hostname = "acrux";
  fingerprint.enable = true;
  intel.enable = true;
  keyboard = {
    kbdLayout = "br";
    kbdConsole = "br-abnt2";
  };
  nh.enable = true;
  cpu.intel.enable = true;
  camera.enable = true;
}
