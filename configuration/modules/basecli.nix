{ config, pkgs, inputs, ... }:
{
  programs = {

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
      enableSSHSupport = true;
    };

    bash = { completion.enable = true; };
    zsh.enable = true;

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
