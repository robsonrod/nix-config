{ config, pkgs, inputs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
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
