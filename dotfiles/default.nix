{ config, lib, pkgs, ... }:

{
  home.file = {

    ".config/bin" = {
      source = bin/.config/bin;
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

  };

}
