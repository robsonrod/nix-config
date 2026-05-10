{ config, pkgs, inputs, vars, ... }:
{


  home.sessionPath = [
    "$HOME/.config/bin"
  ];

  hyprland.enable = true;
  hyprpaper.enable = true;
  hypridle.enable = true;
  hyprshot.enable = true;
  wlogout.enable = true;

  bat.enable = true;
  btop.enable = true;
  eza.enable = true;
  git.enable = true;
  nmdmenu.enable = true;
  ripgrep.enable = true;
  starship.enable = true;
  yazi.enable = true;
  zoxide.enable = true;
  zsh.enable = true;
  neovim.enable = true;
  gpg.enable = true;
  udiskie.enable = true;
  bluetooth.enable = true;
  dunst.enable = true;
  picom.enable = true;
  mpd.enable = true;
  fzf.enable = true;
  jq.enable = true;
  fd.enable = true;
  documentation.enable = true;
  direnv.enable = true;
  vivid.enable = true;
  hstr.enable = true;
  grc.enable = true;
  hwinfo.enable = true;
  xdgconfig.enable = true;
  cliapps.enable = true;
  wofi.enable = true;

  myconfig = {
    xdg.enable = true;
    ssh.enable = true;
    thunar.enable = true;
  };

  zathura.enable = true;
  nsxiv.enable = true;
  peek.enable = true;
  google-chrome.enable = true;
  chromium.enable = true;
  firefox.enable = true;
  librewolf.enable = true;
  ghostty.enable = true;
  fastfetch.enable = true;
  theme.enable = true;
  nerdFonts.enable = true;
  mpv.enable = true;
  calibre.enable = true;

}
