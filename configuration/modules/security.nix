{ config, pkgs, inputs, ... }:
{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services = {
      greetd.enableGnomeKeyring = true;
    };

  };
}
