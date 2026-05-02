{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.cpu.intel;
in
{
  options.cpu.intel = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    boot = {
      initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "usbhid" "sd_mod" "i915" ];
      kernelParams = [
        "i915.enable_psr=0"
        "i915.force_probe=46a6"
      ];
    };

    hardware.cpu.intel.updateMicrocode = true;

    services = {
      thermald.enable = true;
    };
  };

}
