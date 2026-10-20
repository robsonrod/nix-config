{ config, pkgs, ... }:

let
  envocado = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
    pname = "envocado";
    version = "2.0.0";

    src = pkgs.fetchFromCodeberg {
      owner = "robsonrod";
      repo = "envocado";
      sha256 = "sha256-fDkChildixcitwdKKCmSS93oxwDxaiQ6NIkWokfnKNo=";
      rev = "v2.0.0";
    };

    cargoHash = "sha256-79vUGgzARHB5V0isGvBo1RwLHBDiZ1OgqKaUrRzFPxY=";
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
