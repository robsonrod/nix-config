{ config, pkgs, inputs, ... }:
{

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

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
