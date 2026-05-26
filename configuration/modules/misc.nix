{ config, pkgs, inputs, ... }:
{

  services = {
    fwupd.enable = true;
    acpid.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  systemd = {
    # Prevent boot logs from corrupting tuigreet
    services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";

      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;
  };

  system = {
    stateVersion = "20.05";
    copySystemConfiguration = false;
  };
}
