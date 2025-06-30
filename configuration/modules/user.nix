{ config, pkgs, inputs, ... }:
{
  users.users.robson = {
    isNormalUser = true;
    description = "robson";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "vboxusers"
      "input"
      "sound"
      "docker"
    ];
  };
}
