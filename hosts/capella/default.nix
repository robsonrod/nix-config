{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../configuration/capella.nix
  ];

  hostname.hostname = "capella";
  fingerprint.enable = true;
  intel.enable = true;
  keyboard = {
    kbdLayout = "pt,us";
    kbdConsole = "br-abnt2";
  };
  nh.enable = true;
  cpu.intel.enable = true;
}
