{ config, pkgs, inputs, ... }:
{
  hardware = {
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          MultiProfile = "multiple";
        };
      };
    };
  };

  services = {
    blueman.enable = true;
  };

}
