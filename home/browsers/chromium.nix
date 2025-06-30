{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.chromium;
in
{
  options.chromium = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      chromium = {
        enable = true;
	package = pkgs.brave;
	extensions = [
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        ];
        commandLineArgs = [
         "--disable-features=WebRtcAllowInputVolumeAdjustment"
        ];
      };
    };

  };

}