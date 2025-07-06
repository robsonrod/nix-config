{ config, pkgs, inputs, ... }:
{

  services = {
    fwupd.enable = true;
    acpid.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  system = {
    stateVersion = "20.05";
    copySystemConfiguration = false;
  };
}
