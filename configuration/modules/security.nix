{ config, pkgs, inputs, ... }:
{
  security = {
    polkit.enable = true;
    rtkit.enable = true;

    pam.services = {
      betterlockscreen.fprintAuth = true;
      login.fprintAuth = true;
      sudo.fprintAuth = true;
      polkit.fprintAuth = true;

      i3lock = {
        enable = true;
        text = ''
          	auth      include login
                  account   include login
                  password  include login
                  session   include login
        '';
      };
    };

  };



}
