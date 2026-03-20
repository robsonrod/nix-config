{ config, pkgs, inputs, ... }:
{
  environment = {
    localBinInPath = true;

    systemPackages = with pkgs; [
      alsa-utils
      arandr
      cacert
      curl
      dunst
      feh
      font-manager
      libinput-gestures
      libnotify
      libcamera
      lm_sensors
      nixpkgs-fmt
      ntfsprogs
      pulseaudio
      pavucontrol
      picom
      playerctl
      polybarFull
      pulsemixer
      rofi
      rofi-calc
      scrot
      sxhkd
      wget
      killall
      openssl
      p7zip
      unzip
      zip
      procps
      xcape
      xauth
      xdpyinfo
      xhost
      xinit
      xinput
      xkill
      xrandr
      xset
      xmodmap
      v4l-utils
      cheese
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
      # hyprland
      hyprpaper
      hyprlock
      hyprpicker
      grim
      slurp
      wl-clip-persist
      cliphist
    ];
  };

  programs = {
    thunar = {
      enable = true;
    };

    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    waybar = { enable = true; };

    dconf = { enable = true; };

    fish = { enable = true; };
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

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services = {
    printing = { enable = true; };
    gvfs = { enable = true; };
    tumbler = { enable = true; };
    dbus = { enable = true; };
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

    displayManager = {
      defaultSession = "hyprland";
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    xserver = {
      enable = true;
      autorun = false;
      dpi = 200;

      desktopManager = {
        xterm = { enable = true; };
      };

    };

    logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandlePowerKey = "ignore";
    };

  };
}

