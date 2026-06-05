{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.yazi;
in {
  options.yazi = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      flavors = {
        gruvbox = pkgs.fetchFromGitHub {
          owner = "bennyyip";
          repo = "gruvbox-dark.yazi";
          rev = "main";
          sha256 = "sha256-Y/i+eS04T2+Sg/Z7/CGbuQHo5jxewXIgORTQm25uQb4=";
        };
      };

      theme = {
        flavor = {
          dark = "gruvbox";
        };
      };
    };

  };
}
