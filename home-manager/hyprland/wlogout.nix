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
        window {
          background-color: rgba(40, 40, 40, 0.92);
        }

        button {
          background-color: #282828;
          color: #ebdbb2;

          border: 3px solid #504945;
          border-radius: 16px;

          margin: 20px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:hover,
        button:focus {
          background-color: #3c3836;
          border-color: #d79921;
          color: #fabd2f;
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
