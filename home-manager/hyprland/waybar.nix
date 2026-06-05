{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let
  cfg = config.waybar;
  timeout = 300;
in
{
  options.waybar = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings = [
        {
          layer = "top";
          position = "top";
          height = 34;
          spacing = 4;

          modules-left = [
            "custom/nixicon"
            "hyprland/workspaces"
            "hyprland/language"
            "idle_inhibitor"
            "keyboard-state"
          ];

          modules-center = [
            "hyprland/window"
          ];

          modules-right = [
            "hyprland/submap"
            "network"
            "pulseaudio"
            "backlight"
            "cpu"
            "memory"
            "temperature"
            "battery"
            "tray"
            "clock"
          ];

          # -------------------------------------------------
          # Launcher
          # -------------------------------------------------

          "custom/nixicon" = {
            format = " ";
            tooltip = false;
            on-click = "wofi";
          };

          # -------------------------------------------------
          # Workspaces
          # -------------------------------------------------

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = false;

            format = "{name}";
            on-click = "activate";

            on-scroll-up = "hyprctl dispatch workspace e-1";
            on-scroll-down = "hyprctl dispatch workspace e+1";

            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";

              urgent = "";
              active = "";
              default = "";
            };
          };

          # -------------------------------------------------
          # Window
          # -------------------------------------------------

          "hyprland/window" = {
            separate-outputs = true;
            max-length = 50;

            rewrite = {
              "(.*) — Mozilla Firefox" = "$1";
              "(.*) - Google Chrome" = "$1";
              "(.*) — Zen Browser" = "$1";
            };
          };

          # -------------------------------------------------
          # Keyboard Layout
          # -------------------------------------------------

          "hyprland/language" = {
            format = "{}";
            format-en = "US";
            format-pt = "BR";
            max-length = 18;
          };

          "keyboard-state" = {
            numlock = false;
            capslock = false;

            format = "{name} {icon}";

            format-icons = {
              locked = "";
              unlocked = "";
            };
          };

          # -------------------------------------------------
          # Idle Inhibitor
          # -------------------------------------------------

          idle_inhibitor = {
            format = "{icon}";

            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          # -------------------------------------------------
          # Audio
          # -------------------------------------------------

          pulseaudio = {
            scroll-step = 5;

            format = "{volume}% {icon} {format_source}";
            format-muted = " {format_source}";

            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";

            format-source = "{volume}% ";
            format-source-muted = "";

            on-click = "pavucontrol";

            format-icons = {
              headphone = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";

              default = [
                ""
                ""
                ""
              ];
            };
          };

          # -------------------------------------------------
          # Backlight
          # -------------------------------------------------

          backlight = {
            format = "{percent}% {icon}";
            min-length = 6;

            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };

          # -------------------------------------------------
          # Network
          # -------------------------------------------------

          network = {
            format-wifi = "{signalStrength}% ";
            format-ethernet = "󰈀";

            format-linked = "{ifname} (No IP)";
            format-disconnected = "󰖪";

            tooltip-format = "{ifname} via {gwaddr}";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };

          # -------------------------------------------------
          # CPU / Memory / Temp
          # -------------------------------------------------

          cpu = {
            format = "{usage}% ";
            tooltip = true;
          };

          memory = {
            format = "{}% ";
          };

          temperature = {
            critical-threshold = 80;

            format = "{temperatureC}°C {icon}";
            format-critical = "{temperatureC}°C ";

            format-icons = [
              ""
              ""
              ""
            ];
          };

          # -------------------------------------------------
          # Battery
          # -------------------------------------------------

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };

            format = "{capacity}% {icon}";
            format-charging = "{capacity}% 󱐋";
            format-plugged = "{capacity}% ";

            format-warning = "{capacity}% ";
            format-critical = "{capacity}% ";

            format-alt = "{time} {icon}";

            tooltip = true;

            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          # -------------------------------------------------
          # Tray
          # -------------------------------------------------

          tray = {
            spacing = 8;
          };

          # -------------------------------------------------
          # Clock
          # -------------------------------------------------

          clock = {
            format = " {:%H:%M}";
            format-alt = "{:%Y-%m-%d}";

            tooltip-format =
              "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

        }
      ];

      style = ''
        @define-color base00 #282828;
        @define-color base01 #32302f;
        @define-color base02 #504945;
        @define-color base03 #665c54;
        @define-color base04 #bdae93;
        @define-color base05 #d4be98;
        @define-color base06 #ddc7a1;
        @define-color base07 #ebdbb2;
        @define-color base08 #ea6962;
        @define-color base09 #e78a4e;
        @define-color base0A #d8a657;
        @define-color base0B #a9b665;
        @define-color base0C #89b482;
        @define-color base0D #7daea3;
        @define-color base0E #d3869b;
        @define-color base0F #bd6f3e;

                * {
                  border: none;
                  border-radius: 0;
                  min-height: 0;

                  font-family: "JetBrainsMono Nerd Font", monospace;
                  font-size: 12px;
                  font-weight: 500;

                  transition:
                    background-color 120ms ease,
                    color 120ms ease,
                    border-color 120ms ease;
                }

                window#waybar {
                  background: alpha(@base01, 0.92);
                  color: @base05;

                  border: 2px solid @base03;
                  border-radius: 10px;
                }

                #battery,
                #cpu,
                #memory,
                #network,
                #pulseaudio,
                #backlight,
                #clock,
                #temperature,
                #language,
                #idle_inhibitor,
                #tray {
                  background: @base02;

                  margin: 4px 3px;
                  padding: 0 10px;

                  border-radius: 8px;
                }

                #custom-nixicon {
                  color: @base0D;

                  margin-left: 10px;
                  margin-right: 4px;

                  font-size: 15px;
                }

                #workspaces {
                  margin: 0 4px;
                }

                #workspaces button {
                  color: @base04;

                  margin: 4px 2px;
                  padding: 0 8px;

                  border-radius: 8px;

                  background: transparent;
                }

                #workspaces button:hover {
                  background: @base02;
                  color: @base05;
                }

                #workspaces button.active {
                  background: @base03;
                  color: @base0B;
                }

                #workspaces button.urgent {
                  background: @base08;
                  color: @base01;
                }

                #window {
                  color: @base05;

                  font-size: 12px;
                  font-weight: 500;
                }

                #cpu {
                  color: @base05;
                }

                #memory {
                  color: @base05;
                }

                #network {
                  color: @base05;
                }

                #network.disconnected {
                  color: @base08;
                }

                #battery {
                  color: @base05;
                }

                #battery.warning {
                  color: @base0A;
                }

                #battery.critical {
                  color: @base08;
                }

                #battery.charging {
                  color: @base0C;
                }

                #pulseaudio {
                  color: @base05;
                }

                #pulseaudio.muted {
                  color: @base04;
                }

                #temperature {
                  color: @base05;
                }

                #temperature.critical {
                  color: @base08;
                }

                #idle_inhibitor.activated {
                  color: @base0A;
                }

                #idle_inhibitor.deactivated {
                  color: @base04;
                }

                #tray {
                  padding: 0 6px;
                }

                #tray > .passive {
                  -gtk-icon-effect: dim;
                }

                #tray > .needs-attention {
                  background: @base08;
                  border-radius: 6px;
                }

                #clock {
                  color: @base07;

                  margin-right: 6px;
                }

                #language {
                  color: @base06;

                  letter-spacing: -0.5px;
                }

                tooltip {
                  background: @base01;
                  border: 1px solid @base03;
                  border-radius: 8px;
                }

                tooltip label {
                  color: @base05;
                }
      '';
    };
  };
}

