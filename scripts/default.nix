{ pkgs }:

let
  dir = ./.;

  files =
    builtins.filter
      (name:
        name != "default.nix"
        && builtins.match ".*\\.nix" name != null)
      (builtins.attrNames (builtins.readDir dir));

in

map
  (file: import (dir + "/${file}") { inherit pkgs; })
  files
