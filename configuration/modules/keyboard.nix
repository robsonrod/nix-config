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
      default = "us";
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

  };

}
