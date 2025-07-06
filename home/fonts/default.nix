{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.nerdFonts;
in
{
  options.nerdFonts = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    font-awesome
    source-code-pro
    fira-code
    emacs-all-the-icons-fonts
    nerd-fonts.terminess-ttf
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu
    nerd-fonts.roboto-mono
    nerd-fonts.fira-code
  ];

  };

}

