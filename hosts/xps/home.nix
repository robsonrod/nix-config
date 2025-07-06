{ config, pkgs, inputs, ... }:
{
  home = {
    username = "robson";
    homeDirectory = "/home/robson";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  git.enable = true;
  cliapps.enable = true;

  emacs.enable = true;
  gpg.enable = true;
  zathura.enable = true;
  peek.enable = true;
  google-chrome.enable = true;
  chromium.enable = true;
  firefox.enable = true;

  kitty.enable = true;
  nerdFonts.enable = true;
  screenlock.enable = true;

}
