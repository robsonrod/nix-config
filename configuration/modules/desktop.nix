{ config, pkgs, inputs, ... }:
{
  environment = {
    localBinInPath = true;

    systemPackages = with pkgs; [
      alsa-utils
      cacert
      curl
      font-manager
      libinput-gestures
      libnotify
      libcamera
      lm_sensors
      nixpkgs-fmt
      pavucontrol
      playerctl
      pulsemixer
      wget
      killall
      openssl
      p7zip
      unzip
      zip
      procps
      v4l-utils
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
      gnumake
      gcc
      # hyprland
      hyprpicker
      grim
      slurp
      wl-clip-persist
      wl-clipboard
      wlr-randr
      cliphist
      wf-recorder
      nwg-displays
      nwg-look
      wpaperd
      wtype
    ];
  };

  programs = {
    thunar = {
      enable = true;
    };

    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };

    waybar = { enable = true; };

    dconf = { enable = true; };

  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services = {
    printing = { enable = true; };
    gvfs = { enable = true; };
    tumbler = { enable = true; };
    dbus = {
      enable = true;
      implementation = "broker";
    };
    gnome = {
      gnome-keyring = {
        enable = true;
      };
    };

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    logind.settings.Login = {
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitch = "ignore";
      HandlePowerKey = "ignore";

    };

  };
}

