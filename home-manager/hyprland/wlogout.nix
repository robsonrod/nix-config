{ config, options, lib, pkgs, ... }:
with lib;
with lib.types;
let
  cfg = config.wlogout;
  bgImageSection = name: ''
    #${name} {
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    }
  '';
in
{
  options.wlogout = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "swaylock";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "logout";
          action = "hyprshutdown";
          text = "Logout";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
      ];

      style = ''
          * {
          background-image: none;
          box-shadow: none;
          }

            window {
            	background-color: rgba(36, 39, 58, 0.90);
            }

            button {
            	border-radius: 0;
            	border-color: #8aadf4;
            	text-decoration-color: #cad3f5;
            	color: #cad3f5;
            	background-color: #1e2030;
            	border-style: solid;
            	border-width: 1px;
            	background-repeat: no-repeat;
            	background-position: center;
            	background-size: 25%;
            }

            button:focus, button:active, button:hover {
            	background-color: rgb(53, 57, 75);
            	outline-style: none;
            }
        #lock {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/lock.png");
        }
        #logout {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/logout.png");
        }
        #shutdown {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png");
        }
        #reboot {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/reboot.png");
        }
      '';
    };
  };
}
