{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.theme;
in {
  options.theme = {
    enable = mkOption {
      type = bool;
      default = false;
    };

    cursor = {
      size = mkOption {
        type = int;
        default = 24;
      };

      theme = mkOption {
        type = str;
        default = "Adwaita";
      };
    };

  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dconf
      dconf-editor
      adwaita-icon-theme
    ];

    gtk = {
      enable = true;

      theme = {
        name = "Gruvbox-Dark";
        package = pkgs.gruvbox-gtk-theme;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = cfg.cursor.theme;
        size = cfg.cursor.size;
        package = pkgs.adwaita-icon-theme;
      };

      font = {
        name = "Roboto 11";
        package = pkgs.nerd-fonts.roboto-mono;
      };

      gtk3.extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-application-prefer-dark-theme = true;
        gtk-xft-rgba = "rgb";
      };

      gtk4.extraConfig = {
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = true;
        gtk-decoration-layout = ":menu,appmenu";
      };

      gtk3.bookmarks = [
        "file://${config.home.homeDirectory}/Documents"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/Music"
        "file://${config.home.homeDirectory}/Pictures"
        "file://${config.home.homeDirectory}/Videos"
      ];

    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

  };
}
