{ config, pkgs, inputs, ... }:
{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services = {
      sddm.enableGnomeKeyring = true;
      hyprlock.enableGnomeKeyring = true;
    };

  };
}
