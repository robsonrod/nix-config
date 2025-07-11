{ config, pkgs, ... }:

{
  imports = [
    ./browsers/chrome.nix
    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./cli/git.nix
    ./cli/cliapps.nix
    ./games/wine.nix
    ./gui/zathura.nix
    ./gui/peek.nix
    ./gui/theme.nix
    ./gui/xresources.nix
    ./gui/stumpwm.nix
    ./editors/emacs.nix
    ./editors/neovim.nix
    ./editors/vscode.nix
    ./terminals/kitty.nix
    ./terminals/urxvt.nix
    ./terminals/tmux.nix
    ./terminals/tmuxinator.nix
    ./services/gpg.nix

    ../dotfiles
    ./fonts
  ];
}

