{ config, pkgs, ... }:
{

  users.users.robson = {
    isNormalUser = true;
    group = "robson";
  };

  users.groups.robson = { };

  fileSystems."/" = {
    device = "/dev/null";
    fsType = "tmpfs";
  };
}
