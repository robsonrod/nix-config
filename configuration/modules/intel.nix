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

  config = mkIf cfg.enable
    {
      boot = {
        initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "usbhid" "sd_mod" "i915" ];
        kernelParams = [
          "i915.enable_psr=0"
          "i915.force_probe=46a6"
        ];
      };

      powerManagement = {
        enable = true;
        cpuFreqGovernor = "ondemand"; # scales frequency dynamically based on load
      };

      hardware.cpu.intel.updateMicrocode = true;

      services = {
        thermald.enable = true;
      };

      services.tlp.enable = false;
      services.auto-cpufreq = {
        enable = true; # dynamically switches governor based on load
        settings = {
          charger = {
            governor = "powersave";
            turbo = "auto";
          };
          battery = {
            governor = "powersave";
            turbo = "never";
          };
        };
      };


      #      systemd.services.dell-battery-threshold = {
      #        description = "Set Dell XPS battery charge thresholds";
      #        wantedBy = [ "multi-user.target" ];
      #        serviceConfig = {
      #          Type = "oneshot";
      #          ExecStart = "${pkgs.smbios-utils}/bin/smbios-battery-ctl --set-charging-mode custom && ${pkgs.smbios-utils}/bin/smbios-battery-ctl --set-custom-charge-interval 75 80";
      #        };
      #      };

    };
}
