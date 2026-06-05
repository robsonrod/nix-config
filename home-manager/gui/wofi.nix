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
          width = 960;
          height = 500;
          location = "center";
          prompt = "Apps";
          term = "foot";

          allow_images = true;
          image_size = 48;
          columns = 2;

          no_actions = true;
          insensitive = true;
          run_always_parse_args = true;
          hide_scroll = true;
          matching = "fuzzy";
          layer = "overlay";
        };

        style = ''
          @define-color bg0     #282828;
          @define-color bg1     #3c3836;
          @define-color bg2     #504945;
          @define-color bg3     #665c54;

          @define-color fg0     #fbf1c7;
          @define-color fg1     #ebdbb2;
          @define-color fg2     #d5c4a1;

          @define-color red     #fb4934;
          @define-color green   #b8bb26;
          @define-color yellow  #fabd2f;
          @define-color blue    #83a598;
          @define-color purple  #d3869b;
          @define-color aqua    #8ec07c;
          @define-color orange  #fe8019;
          @define-color gray    #928374;

          * {
            font-family: "Inconsolata Nerd Font", monospace;
            font-size: 14px;
          }

          window {
            margin: 0;
            padding: 12px;
            border: 2px solid @yellow;
            border-radius: 10px;
            background-color: @bg0;
            animation: fadeIn 0.2s ease-in-out;
          }

          @keyframes fadeIn {
            from {
              opacity: 0;
            }

            to {
              opacity: 1;
            }
          }

          #outer-box {
            margin: 0;
            padding: 8px;
            background-color: @bg0;
          }

          #inner-box {
            margin: 0;
            padding: 8px;
            background-color: @bg0;
          }

          #scroll {
            margin: 0;
            padding: 0;
            border: none;
          }

          #input {
            margin: 0 0 12px 0;
            padding: 12px;
            border: 2px solid @bg3;
            border-radius: 8px;
            background-color: @bg1;
            color: @fg1;
          }

          #input:focus {
            border-color: @yellow;
          }

          #input image {
            color: @yellow;
          }

          #text {
            margin: 0;
            color: @fg1;
          }

          #entry {
            margin: 4px;
            padding: 10px;
            border-radius: 8px;
            background-color: transparent;
          }

          #entry:hover {
            background-color: @bg1;
          }

          #entry:selected {
            background-color: @bg2;
            border: 2px solid @yellow;
          }

          #entry:selected #text {
            color: @fg0;
          }

          #entry arrow {
            color: @orange;
          }

          #entry:drop(active) {
            background-color: @aqua;
          }
        '';
      };
    };
  };
}

