{ config, pkgs, inputs, ... }:
{

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

}
