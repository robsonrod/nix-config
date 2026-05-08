{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.wofi;
in
{
  options.wofi = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      wofi = {
        enable = true;

        settings = {
          show = "drun";
          width = 450;
          height = 500;
          location = "center";
          prompt = "Apps";
          term = "ghostty";

          allow_images = true;
          image_size = 24;

          no_actions = true;
          insensitive = true;
          run_always_parse_args = true;
          hide_scroll = true;
          matching = "fuzzy";
          layer = "overlay";
        };

        style = ''
          /* =========================
             WINDOW (Applications Menu)
             ========================= */
          window {
              margin: 0px;
              border: 2px solid rgba(183, 189, 248, 0.25);
              border-radius: 14px;

              background-color: rgba(36, 39, 58, 0.75);
              backdrop-filter: blur(12px);

              font-family: "JetBrainsMono Nerd Font";
          }

          /* =========================
             INPUT
             ========================= */
          #input {
              margin: 10px;
              border: 1px solid rgba(183, 189, 248, 0.2);
              border-radius: 10px;
              padding: 10px;

              background-color: rgba(54, 58, 79, 0.6);
              color: #cad3f5;
          }

          /* =========================
             CONTAINERS
             ========================= */
          #inner-box,
          #outer-box,
          #scroll {
              margin: 10px;
              background-color: transparent;
          }

          /* =========================
             ENTRY (APP ITEMS)
             ========================= */
          #entry {
              padding: 10px 12px;
              margin: 4px;

              border-radius: 10px;

              background-color: transparent;
              color: #cad3f5;

              /* consistent alignment */
              display: flex;
              align-items: center;
          }

          #entry:hover {
              background-color: rgba(73, 77, 100, 0.5);
          }

          #entry:selected {
              background-color: rgba(183, 189, 248, 0.18);
              border-left: 3px solid #b7bdf8;
          }

          /* =========================
             ICON CONSISTENCY FIX
             ========================= */
          #img {
              margin-right: 12px;

              /* consistent icon size */
              min-width: 24px;
              min-height: 24px;

              /* keeps icons aligned visually */
              object-fit: contain;
          }

          /* =========================
             TEXT
             ========================= */
          #text {
              color: #cad3f5;
          }
        '';
      };
    };
  };
}

