{ config, pkgs, inputs, ... }:
{
  fish.enable = true;
  git.enable = true;
  cliapps.enable = true;
   
  emacs.enable = true;
  neovim.enable = true;
  gpg.enable = true;
  zathura.enable = true;
  peek.enable = true;
  google-chrome.enable = true;
  chromium.enable = true;
  firefox.enable = true;
  librewolf.enable = true;
  kitty.enable = true;
  theme.enable = true;
  nerdFonts.enable = true;
  xresources.enable = true;
  hyprpaper.enable = true;
  hypridle.enable = true;

  programs.home-manager.enable = true;

}
