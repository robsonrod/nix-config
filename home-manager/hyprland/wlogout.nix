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

      style = ''
        * {
          background: none;
        }

        window {
        	background-color: rgba(0, 0, 0, .5);
        }

        button {
          background: rgba(0, 0, 0, .05);
          border-radius: 8px;
          box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
          margin: 1rem;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:focus, button:active, button:hover {
          background-color: rgba(255, 255, 255, 0.2);
          outline-style: none;
        }

        ${lib.concatMapStringsSep "\n" bgImageSection [
          "lock"
          "logout"
          "suspend"
          "hibernate"
          "shutdown"
          "reboot"
        ]}
      '';
    };
  };
}
