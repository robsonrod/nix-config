{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.myconfig.ssh;
in
{
  options.myconfig.ssh = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        dev = {
          hostname = "10.30.33.204";
          user = "robson";
          port = 22;

          identityFile = "~/.ssh/work_ed25519";
          identitiesOnly = true;

          forwardX11 = true;
          forwardX11Trusted = true;

          compression = true;
          serverAliveInterval = 60;
          serverAliveCountMax = 3;
        };

        "github.com" = {
          hostname = "github.com";
          user = "git";

          identityFile = "~/.ssh/github_ed25519";
          identitiesOnly = true;

          forwardX11 = false;
        };
      };
    };
  };

}
