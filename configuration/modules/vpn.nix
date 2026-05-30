{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.vpn;
in
{
  options.vpn = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    environment = {
      systemPackages = with pkgs; [
        snx-rs
      ];
    };

    systemd.services.snx-rs = {
      enable = true;
      path = [ pkgs.iproute2 pkgs.kmod pkgs.networkmanager ]; # for ip, modprobe and nmcli commands
      description = "SNX-RS VPN client for Linux";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.snx-rs}/bin/snx-rs -m command -l debug";
        Type = "simple";
      };
    };

    networking.firewall.checkReversePath = "loose";

  };
}
