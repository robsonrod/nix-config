{ pkgs }:

pkgs.writeShellApplication {
  name = "wofi-projects";

  runtimeInputs = with pkgs; [
    wofi
  ];

  text = ''
  projects=$(find "''$HOME/dev" -mindepth  2 -maxdepth 2 -type d -printf '%P\n')
  [ -n "''${projects}" ] || exit 1

  selected=$(printf '%s\n' "''${projects}" | wofi --dmenu)
  [ -n "''${selected}" ] || exit 2

  project="''${HOME}/dev/''${selected}"
  footclient --working-directory="''${project}"
  '';
}
