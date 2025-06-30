{ config, pkgs, inputs, ... }:
{
networking = {
    hostName = "iracema";
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

 }