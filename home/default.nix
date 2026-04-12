{ config, pkgs, ... }:
{
  imports = [
    ./browsers/chrome.nix
    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./browsers/nyxt.nix
    ./browsers/librewolf.nix
    ./cli/cliapps.nix
    ./cli/git
    ./cli/networkmanager-dmenu
    ./cli/starship
    ./cli/zsh
    ./cli/fastfetch
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
    ./terminals/alacritty.nix
    ./terminals/urxvt.nix
    ./terminals/tmux.nix
    ./terminals/ghostty.nix
    ./terminals/tmuxinator.nix
    ./services/gpg.nix
    ./services/hyprpaper.nix
    ./services/hypridle.nix

    ../dotfiles
    ./fonts
  ];

  programs.home-manager.enable = true;
}
