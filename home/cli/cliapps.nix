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
      dysk
      vips
    ];

    catppuccin = {
      bat = {
        enable = true;
        flavor = "macchiato";
      };
    };
    programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      jq.enable = true;
      eza = {
        enable = true;
        enableZshIntegration = true;
      };

      ripgrep = {
        enable = true;
        arguments = [ "--hidden" ];
      };

      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
        enableZshIntegration = true;
      };

      bat.enable = true;

      btop.enable = true;
      hstr.enable = true;
      yazi = {
        enable = true;
        enableZshIntegration = true;
      };
      fd.enable = true;
      man.enable = true;
      tealdeer.enable = true;
      direnv.enable = true;

    };

  };
}
