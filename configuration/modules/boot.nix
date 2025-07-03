{ config, pkgs, inputs, ... }:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        devices = [ "nodev" ];
        configurationLimit = 5;
        gfxmodeEfi = "1920x1080x32";
      };
    };
  };

}
