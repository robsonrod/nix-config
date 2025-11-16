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
      xorg.xauth
      xorg.xdpyinfo
      xorg.xhost
      xorg.xinit
      xorg.xinput
      xorg.xkill
      xorg.xrandr
      xorg.xset
      xorg.xmodmap
      v4l-utils
      cheese
      # hyprland
      hyprpaper
      hyprlock
      hyprpicker
      grim
      slurp
      wl-clipboard
    ];
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };

    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    waybar = { enable = true; };

    dconf = { enable = true; };
  };

  services = {
    printing = { enable = true; };
    gvfs = { enable = true; };
    tumbler = { enable = true; };
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
    };

    hypridle = {
      enable = true;
    };

  };
}

