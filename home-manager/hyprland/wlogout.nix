{ config, options, lib, pkgs, ... }:
with lib;
with lib.types;
let
  cfg = config.wlogout;
in
{
  options.wlogout = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    catppuccin.wlogout = {
      enable = true;
      flavor = "macchiato";
      accent = "pink";
    };
    programs.wlogout = {
      enable = true;

      style = ''
        #lock {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/lock.png");
        }
        #logout {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/logout.png");
        }
        #shutdown {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png");
        }
        #reboot {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/reboot.png");
        }
        #suspend {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/suspend.png");
        }
        #hibernate {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png");
        }
      '';
    };
  };
}
