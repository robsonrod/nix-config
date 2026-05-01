{ config, pkgs, ... }:
{
  imports = [
    ./bat
    ./btop
    ./eza
    ./fastfetch
    ./git
    ./networkmanager-dmenu
    ./ripgrep
    ./starship
    ./yazi
    ./zoxide
    ./zsh
    ./jq
    ./fzf
    ./direnv
    ./hstr
    ./fd
    ./vivid
    ./documentation
    ./grc
    ./hwinfo
    ./xdgconfig
    ./others
  ];

}
