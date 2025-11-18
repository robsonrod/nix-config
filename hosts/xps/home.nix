{ config, pkgs, inputs, ... }:
{
  home = {
    username = "robson";
    homeDirectory = "/home/robson";
    stateVersion = "25.05";
  };


  git.enable = true;
  cliapps.enable = true;

  emacs.enable = true;
  gpg.enable = true;
  zathura.enable = true;
  peek.enable = true;
  firefox.enable = true;
  librewolf.enable = true;
  kitty.enable = true;
  theme.enable = true;
  nerdFonts.enable = true;
  xresources.enable = true;

  programs.home-manager.enable = true;

}
