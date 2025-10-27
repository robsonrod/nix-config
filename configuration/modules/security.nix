{ config, pkgs, inputs, ... }:
{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}
