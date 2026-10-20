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

  services = {
    fwupd.enable = true;
    acpid.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  system = {
    stateVersion = "25.11";
    copySystemConfiguration = false;
  };

}
