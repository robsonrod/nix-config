{ config, pkgs, ... }:

{
  imports = [
    ./browsers/chrome.nix
    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./cli/git.nix
    ./cli/cliapps.nix
    ./gui/zathura.nix
    ./gui/peek.nix
    ./editors/emacs.nix
    ./editors/neovim.nix
    ./editors/vscode.nix
    ./terminals/kitty.nix
    ./terminals/urxvt.nix
    ./terminals/tmux.nix
    ./terminals/tmuxinator.nix
    ./services/gpg.nix
  ];
}

