{ config, pkgs, ... }:
{
  imports = [
    ./hyprland
    ./cli
    ./configs
    ./browsers/chrome.nix
    ./browsers/chromium.nix
    ./browsers/firefox.nix
    ./browsers/nyxt.nix
    ./browsers/librewolf.nix
    ./games/wine.nix
    ./gui/zathura.nix
    ./gui/nsxiv.nix
    ./gui/peek.nix
    ./gui/theme.nix
    ./gui/xresources.nix
    ./gui/wallpaper.nix
    ./gui/calibre.nix
    ./gui/mpv.nix
    ./gui/wofi.nix
    ./gui/sioyek.nix
    ./editors/emacs.nix
    ./editors/neovim.nix
    ./editors/vscode.nix
    ./terminals/kitty.nix
    ./terminals/alacritty.nix
    ./terminals/tmux.nix
    ./terminals/ghostty.nix
    ./terminals/foot.nix
    ./services/gpg.nix
    ./services/udiskie.nix
    ./services/bluetooth.nix
    ./services/mpd.nix
    ./services/dunst.nix
    ./services/picom.nix
    ./fonts
  ];

  programs.home-manager.enable = true;
  home.packages =
    import ../scripts { inherit pkgs; };
}
