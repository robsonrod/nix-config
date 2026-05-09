{ config, lib, pkgs, ... }:

{
  home.file = {

    ".config/bin" = {
      source = bin/.config/bin;
      recursive = true;
    };

  };

}
