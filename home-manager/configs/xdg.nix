{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.myconfig.xdg;
in {
  options.myconfig.xdg = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    xdg = {
      desktopEntries.video = {
        name = "video";
        genericName = "VideoViewer";
        exec = "mpv -quiet %f";
        terminal = false;
        type = "Application";
        mimeType = [
          "audio/mpeg"
          "audio/flac"
          "audio/ogg"
          "audio/wav"
          "video/mp4"
          "video/x-matroska"
          "video/webm"
          "video/x-msvideo"
        ];
        categories = [ "AudioVideo" "Video" ];
      };

      desktopEntries.nvim = {
        name = "nvim";
        genericName = "TextEditor";
        exec = "ghostty -e nvim %u";
        terminal = false;
        type = "Application";
        categories = [ "Development" ];
        mimeType = [
          "text/plain"
          "text/markdown"
          "application/json"
          "application/xml"
          "text/x-shellscript"
        ];
      };

      desktopEntries.img = {
        name = "img";
        genericName = "ImageViewer";
        exec = "nsxiv -a %f";
        terminal = false;
        type = "Application";
        mimeType = [
          "image/png"
          "image/jpeg"
          "image/jpg"
          "image/gif"
          "image/webp"
          "image/bmp"
          "image/tiff"
          "image/svg+xml"
        ];
        categories = [ "AudioVideo" "Video" ];
      };

      desktopEntries.pdf = {
        name = "pdf";
        genericName = "PDFViewer";
        exec = "zathura %u";
        terminal = false;
        type = "Application";
        mimeType = [
          "application/pdf"
          "application/epub+zip"
        ];
        categories = [ "Office" "Viewer" ];
      };

      mimeApps = {
        enable = true;

        defaultApplications = {
          "text/html" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];

          # Terminal apps
          "application/x-terminal-emulator" = [ "com.mitchellh.ghostty.desktop" ];

          # Documents
          "application/pdf" = [ "pdf.desktop" ];
          "application/epub+zip" = [ "pdf.desktop" ];

          # Text / code
          "text/plain" = [ "nvim.desktop" ];
          "text/markdown" = [ "nvim.desktop" ];
          "application/json" = [ "nvim.desktop" ];
          "application/xml" = [ "nvim.desktop" ];
          "text/x-shellscript" = [ "nvim.desktop" ];

          # Images
          "image/png" = [ "img.desktop" ];
          "image/jpeg" = [ "img.desktop" ];
          "image/jpg" = [ "img.desktop" ];
          "image/gif" = [ "img.desktop" ];
          "image/webp" = [ "img.desktop" ];
          "image/bmp" = [ "img.desktop" ];
          "image/tiff" = [ "img.desktop" ];
          "image/svg+xml" = [ "img.desktop" ];

          # Audio
          "audio/mpeg" = [ "video.desktop" ];
          "audio/flac" = [ "video.desktop" ];
          "audio/ogg" = [ "video.desktop" ];
          "audio/wav" = [ "video.desktop" ];

          # Video
          "video/mp4" = [ "video.desktop" ];
          "video/x-matroska" = [ "video.desktop" ];
          "video/webm" = [ "video.desktop" ];
          "video/x-msvideo" = [ "video.desktop" ];

          # Archives
          "application/zip" = [ "org.gnome.FileRoller.desktop" ];
          "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
          "application/x-gzip" = [ "org.gnome.FileRoller.desktop" ];
          "application/x-bzip2" = [ "org.gnome.FileRoller.desktop" ];
          "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
          "application/x-rar" = [ "org.gnome.FileRoller.desktop" ];
        };
      };

    };
  };
}
