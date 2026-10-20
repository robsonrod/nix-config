{ config, pkgs, inputs, vars, ... }:
{

  home.sessionPath = [
    "$HOME/.config/bin"
  ];

  bat.enable = true;
  btop.enable = true;
  eza.enable = true;
  git.enable = true;
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
  mpd.enable = true;
  fzf.enable = true;
  jq.enable = true;
  fd.enable = true;
  documentation.enable = true;
  hstr.enable = true;
  grc.enable = true;
  hwinfo.enable = true;

  myconfig = {
    ssh.enable = true;
    thunar.enable = true;
  };

  sioyek.enable = true;
  zathura.enable = true;
  nsxiv.enable = true;
  brave-origin.enable = true;
  foot.enable = true;
  nerdFonts.enable = true;
  mpv.enable = true;
  calibre.enable = true;
}
