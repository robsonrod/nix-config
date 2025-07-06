{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.cliapps;
in {
  options.cliapps = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      file
      grc
      hwinfo
      libnotify
      lshw
      vivid
      xdg-utils
      pinentry
      dysk
      betterlockscreen
      macchina
    ];

    programs = {
      fzf.enable = true;
      jq.enable = true;
      eza.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      bat.enable = true;
      bottom.enable = true;
      hstr.enable = true;
      yazi.enable = true;
      fd.enable = true;
      fastfetch.enable = true;
      man.enable = true;
      tealdeer.enable = true;
    };
  };
}
