{ config, lib, pkgs, ... }:
{
  home.file = {

    ".config/kitty" = {
      source = kitty/.config/kitty;
      recursive = true;
    };

    ".bashrc" = {
      source = ./bash/.bashrc;
    };

    ".bash_profile" = {
      source = bash/.bash_profile;
    };

    ".config/bash" = {
      source = bash/.config/bash;
      recursive = true;
    };


    ".config/bin" = {
      source = bin/.config/bin;
      recursive = true;
    };

    ".config/bat" = {
      source = bat/.config/bat;
      recursive = true;
    };

    ".config/wallpaper" = {
      source = wallpaper/.config/wallpaper;
      recursive = true;
    };

    ".config/zathura" = {
      source = zathura/.config/zathura;
      recursive = true;
    };

    ".config/starship" = {
      source = starship/.config/starship;
      recursive = true;
    };

    ".config/macchina" = {
      source = macchina/.config/macchina;
      recursive = true;
    };

    ".config/dunst" = {
      source = dunst/.config/dunst;
      recursive = true;
    };

    ".config/picom" = {
      source = picom/.config/picom;
      recursive = true;
    };

    ".config/rofi" = {
      source = rofi/.config/rofi;
      recursive = true;
    };

    ".config/bspwm" = {
      source = bspwm/.config/bspwm;
      recursive = true;
    };

    ".config/polybar" = {
      source = polybar/.config/polybar;
      recursive = true;
    };

    ".config/sxhkd" = {
      source = sxhkd/.config/sxhkd;
      recursive = true;
    };

    ".config/git" = {
      source = git/.config/git;
      recursive = true;
    };

  };

}
