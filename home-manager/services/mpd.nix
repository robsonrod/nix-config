{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.mpd;
in
{
  options.mpd = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mpc
    ];

    services.mpd = {
      enable = true;
      musicDirectory = "~/Music";
      network = {
        listenAddress = "any";
        port = 6600;
      };

      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Output"
        }
      '';
    };

  };
}
