{ config, pkgs, inputs, ... }:
{
  environment = {
    localBinInPath = true;

    systemPackages = with pkgs; [
      v4l-utils
      alsa-utils
      arandr
      betterlockscreen
      cacert
      curl
      dunst
      feh
      font-manager
      libinput-gestures
      libnotify
      lm_sensors
      nixpkgs-fmt
      ntfsprogs
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
      xorg.xauth
      xorg.xdpyinfo
      xorg.xhost
      xorg.xinit
      xorg.xinput
      xorg.xkill
      xorg.xrandr
      xorg.xset
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

    dconf = { enable = true; };
  };

  services = {
    printing = { enable = true; };
    gvfs = { enable = true; };
    tumbler = { enable = true; };

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
      };
    };

    displayManager = {
      defaultSession = "xfce";
    };

    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      enable = true;
      autorun = false;
      #dpi = 200;

      displayManager = {
        lightdm.enable = true;
        #startx.enable = true;
      };

      desktopManager = {
        xfce = { enable = true; };
      };

      windowManager = {
        bspwm = {
          enable = true;
        };
      };

      xautolock = {
        enable = true;
        time = 5;
        locker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
        killtime = 10;
        killer = "/run/current-system/systemd/bin/systemctl suspend";
        extraOptions = [ "-detectsleep" ];
      };
    };
  };
}
