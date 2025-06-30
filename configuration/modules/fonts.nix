{ config, pkgs, inputs, ... }:
{
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
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