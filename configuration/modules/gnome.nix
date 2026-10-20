{ config, pkgs, ... }:

{
  # Desktop
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.power-profiles-daemon.enable = false;

  # Integração com GNOME
  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # Pacotes do sistema
  environment = {
    localBinInPath = true;

    systemPackages = with pkgs; [
      # Utilitários
      alsa-utils
      cacert
      curl
      wget
      openssl
      p7zip
      unzip
      zip
      killall
      procps
      gnumake
      gcc
      nixpkgs-fmt

      # Áudio e vídeo
      libnotify
      pavucontrol
      playerctl
      pulsemixer
      v4l-utils
      libcamera

      # Diagnóstico de hardware
      lm_sensors
      libinput-gestures

      # Personalização e administração GNOME
      gnome-tweaks
      gnome-system-monitor

      # Desenvolvimento e ferramentas
      pkgs.home-manager
    ];
  };

  # Impressão e integração com dispositivos
  services.printing.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Touchpad
  services.libinput = {
    enable = true;

    touchpad = {
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };
}
