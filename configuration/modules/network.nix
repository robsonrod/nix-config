{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.hostname;
in
{
  options.hostname = {
    hostname = mkOption {
      type = str;
      default = "iracema";
    };
  };

  config = {

  networking = {
    hostName = "${cfg.hostname}";
    networkmanager = {
      enable = true;
      dns = "dnsmasq";
      dhcp = "internal";
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [8080];
      allowedTCPPortRanges  = [{ from = 4000; to = 4010; }];
    };    
  };


  programs = {
    nm-applet.enable = true;
  };

};

}