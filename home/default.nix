{ config, pkgs, ... }:

{
  imports = [
    ./browsers/chrome.nix
    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./browsers/nyxt.nix
    ./browsers/librewolf.nix
    ./cli/git.nix
    ./cli/cliapps.nix
    ./cli/fish.nix
    ./games/wine.nix
    ./gui/zathura.nix
    ./gui/peek.nix
    ./gui/theme.nix
    ./gui/xresources.nix
    ./gui/stumpwm.nix
    ./gui/wallpaper.nix
    ./editors/emacs.nix
    ./editors/neovim.nix
    ./editors/vscode.nix
    ./terminals/kitty.nix
    ./terminals/urxvt.nix
    ./terminals/tmux.nix
    ./terminals/tmuxinator.nix
    ./services/gpg.nix
    ./services/hyprpaper.nix
    ./services/hypridle.nix

    ../dotfiles
    ./fonts
  ];
}

