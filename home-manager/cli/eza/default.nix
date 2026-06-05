{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.eza;
in {
  options.eza = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EZA_COLORS = ''
        di=34
        fi=0
        ex=32
        ln=36
        pi=33
        so=35
        bd=33
        cd=33
        su=31
        sg=31
        tw=32
        ow=33
        uu=31
        un=90
        gu=31
        gn=90
        da=36
      '';
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";

      extraOptions = [
        "--color=always"
        "--group-directories-first"
        "--header"
        "--git"
        "--octal-permissions"
        "--time-style=long-iso"
      ];
    };

    home.shellAliases = {
      ls = "eza";
      ll = "eza -lah --git";
      la = "eza -a";
      lt = "eza --tree --level=2";
      lg = "eza -lah --git-ignore";
      tree = "eza --tree";
    };

  };
}

