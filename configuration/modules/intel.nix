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

    # Disable conflicting power profile daemons
    services.power-profiles-daemon.enable = false;

    # Enable TLP with custom rules for the XPS 9320 Intel platform
    services.tlp = {
      enable = true;
      settings = {
        # --- CPU Performance & Core Scheduling ---
        CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # Intel Energy Performance Hints (Balances P/E-cores aggressively on battery)
        CPU_ENERGY_PERF_POLICY_ON_AC = "ondemand";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power"; # Pushes more tasks to E-cores to save power

        # Prevent thermal spikes on your lap, allow boost when plugged in
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # Dynamic HWP boost controls
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        # --- Dell Hardware Battery Care ---
        # Keeps your battery healthy if plugged into a desk dock frequently
        # TLP uses 'natacpi (dell_laptop)' for the XPS series
        START_CHARGE_THRESH_BAT0 = 75; # Start charging when it drops below 75%
        STOP_CHARGE_THRESH_BAT0 = 80; # Stop charging at 80% to mitigate battery degradation

        # --- Storage & PCIe Link Power Management ---
        # XPS 9320 uses fast NVMe drives; optimize their link state
        SATA_LINKPWR_ON_AC = "med_power_with_dipm";
        SATA_LINKPWR_ON_BAT = "min_power";

        # Enable runtime power management for the PCIe lanes and Intel Iris Xe graphics
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        # --- Connectivity & Audio Saving ---
        # Keep Wi-Fi performance up, save power when on battery
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        # Put Intel HD Audio to sleep after 1 second of inactivity
        SOUND_POWER_SAVE_ON_AC = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        SOUND_POWER_SAVE_CONTROLLER = "Y";

        # --- USB Autosuspend Exceptions ---
        USB_AUTOSUSPEND = 1;
        # If external webcams, docks, or mice act up, you can exclude them here
      };
    };
  };

}
