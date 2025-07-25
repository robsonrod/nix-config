{ config, pkgs, inputs, ... }:
{
  environment = {
    localBinInPath = true;

    systemPackages = with pkgs; [
      betterlockscreen
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
      defaultSession = "xfce";
    };

    xserver = {
      enable = true;
      autorun = false;
      dpi = 200;

      displayManager = {
        #lightdm = {
        #  enable = true;
        #  greeters.gtk.enable = true;
        #};
        startx.enable = true;
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

