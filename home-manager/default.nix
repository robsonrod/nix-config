{ config, pkgs, ... }:
{
  imports = [
    ./browsers/chrome.nix
    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./browsers/nyxt.nix
    ./browsers/librewolf.nix
    ./hyprland
    ./cli
    ./games/wine.nix
    ./gui/zathura.nix
    ./gui/nsxiv.nix
    ./gui/peek.nix
    ./gui/theme.nix
    ./gui/xresources.nix
    ./gui/wallpaper.nix
    ./gui/calibre.nix
    ./gui/mpv.nix
    ./editors/emacs.nix
    ./editors/neovim.nix
    ./editors/vscode.nix
    ./terminals/kitty.nix
    ./terminals/alacritty.nix
    ./terminals/tmux.nix
    ./terminals/ghostty.nix
    ./services/gpg.nix

    ../dotfiles
    ./fonts
  ];

  programs.home-manager.enable = true;
}
