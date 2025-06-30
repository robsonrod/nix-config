{ config, pkgs, inputs, ... }:
{
  programs = {

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };

    bash = { completion.enable = true; };
  };

  services = {

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };


  };
}
