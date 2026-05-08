{ config, lib, pkgs, ... }:

{
  home.file = {

    ".config/bin" = {
      source = bin/.config/bin;
      recursive = true;
    };

    ".config/rofi" = {
      source = rofi/.config/rofi;
      recursive = true;
    };

  };

}
