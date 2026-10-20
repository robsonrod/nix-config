{ config, pkgs, inputs, vars, ... }:
{
  users.users.${vars.user} = {
    isNormalUser = true;
    description = vars.user;
    shell = pkgs.zsh;
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
