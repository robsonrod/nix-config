{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.docker;

  docker-nuke = pkgs.writeShellScriptBin "docker-nuke" ''
    set -e

    containers=$(docker ps -aq)

    if [ -n "$containers" ]; then
      docker stop $containers
      docker rm $containers
    fi

    docker network prune -f
    docker volume prune -f
    docker image prune -af
  '';

in
{
  options.docker.enable = mkEnableOption "Docker";

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;

      autoPrune = {
        enable = true;
      };
    };

    environment.systemPackages = [
      docker-nuke
    ];
  };
}
