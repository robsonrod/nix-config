{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.keyboard;
in
{
  options.keyboard = {
    kbdLayout = mkOption {
      type = str;
      default = "br";
    };

    kbdVariant = mkOption {
      type = str;
      default = "";
    };

    kbdConsole = mkOption {
      type = str;
      default = "";
    };

  };

  config = {
    services.xserver = {
      xkb = {
        layout = "${cfg.kbdLayout}";
        variant = "${cfg.kbdVariant}";
      };
    };

    console = {
      keyMap = "${cfg.kbdConsole}";
    };

    environment = {
      systemPackages = with pkgs; [
        interception-tools
        interception-tools-plugins.caps2esc
      ];
    };

    services.interception-tools = {
      enable = true;
      plugins = [
        pkgs.interception-tools-plugins.caps2esc
      ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
             EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
  };

}
