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
            @define-color bg0     #1d2021;
          @define-color bg1     #282828;
          @define-color bg2     #32302f;
          @define-color bg3     #3c3836;

          @define-color fg0     #d4be98;
          @define-color fg1     #ddc7a1;
          @define-color fg2     #bdae93;

          @define-color red     #ea6962;
          @define-color green   #a9b665;
          @define-color yellow  #d8a657;
          @define-color blue    #7daea3;
          @define-color purple  #d3869b;
          @define-color aqua    #89b482;
          @define-color orange  #e78a4e;
          @define-color gray    #928374;

          @define-color bg_red      #ea6962;
          @define-color bg_green    #a9b665;
          @define-color bg_yellow   #d8a657;
          @define-color bg_blue     #7daea3;
          @define-color bg_purple   #d3869b;
          @define-color bg_aqua     #89b482;
          @define-color bg_orange   #e78a4e;

          @define-color bg_dim      #141617;

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

