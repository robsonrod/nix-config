{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.hypridle;
  timeout = 300;
in
{
  options.hypridle = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      package = pkgs.hypridle;

      settings = {

        general = {
          #hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })'
          #hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'   
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
          lock_cmd = "pgrep hyprlock || ${lib.getExe config.programs.hyprlock.package}";
        };

        listener = [
          # Lock the screen
          {
            inherit timeout;
            on-timeout = "loginctl lock-session";
          }
          # Turn off screen
          {
            timeout = timeout + 120;
            on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
            on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
          }
          # Suspend the system
          {
            timeout = timeout * 2;
            on-timeout = "systemctl suspend";
          }
        ];
      };

    };

  };
}
