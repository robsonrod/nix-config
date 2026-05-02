{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.camera;
in
{
  options.camera = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    boot = {
      extraModulePackages = with config.boot.kernelPackages; [ ipu6-drivers ];
    };

    hardware.firmware = with pkgs; [
      ipu6-camera-bins
      ivsc-firmware
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="intel-ipu6-psys", MODE="0660", GROUP="video"
    '';
  };

}
