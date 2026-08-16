{ config, pkgs, ... }:

let
  envocado = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
    pname = "envocado";
    version = "0.1.0";

    src = pkgs.fetchFromCodeberg {
      owner = "robsonrod";
      repo = "envocado";
      sha256 = "sha256-vv8ZCqfTcqaUeU8gl3RhHy6SMgQpHgWv6jH7yUzxVD8=";
      rev = "main";
    };

    cargoHash = "sha256-6qkA9VsPQIWEwA/PWiXaILw0ZjV4Is7Uo5h44oolnrs=";
    doCheck = false;

    nativeBuildInputs = [
      pkgs.pkg-config
      pkgs.wrapGAppsHook4
    ];

    meta = {
      description = "Open source functions exporter";
      homepage = "https://codeberg.org/robsonrod/envocado";
      license = pkgs.lib.licenses.agpl3Plus;
      maintainers = with pkgs.lib.maintainers; [
      ];
    };
  });
in
{
  home.packages = [
    envocado
  ];
}
