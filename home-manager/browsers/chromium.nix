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
          { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
          { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
          { id = "kceglpglilklghkgofolieongaolnaob"; } # Cookie AutoDelete
        ];
        commandLineArgs = [
          "--disable-features=WebRtcAllowInputVolumeAdjustment"
        ];
      };
    };

  };

}
