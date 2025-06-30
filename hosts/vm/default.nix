{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ../../configuration
    ];

   hostname.hostname = "nixos-vm";

}
