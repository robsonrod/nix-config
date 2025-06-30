{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.gpg;
in {
  options.gpg = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-tty;
      defaultCacheTtl = 1800;
    };
  };
}
