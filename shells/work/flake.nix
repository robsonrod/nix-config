{
  description = "A Nix-flake-based work environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    snx-rs-5 = {
      url = "github:ancwrd1/snx-rs/v4.9.0";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, snx-rs-5 }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
            };
          });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs, system }:
        let
          snx-rs-v4 = pkgs.rustPlatform.buildRustPackage {
            pname = "snx-rs";
            version = "4.9.0";

            src = snx-rs-5;

            cargoLock = {
              lockFile = "${snx-rs-5}/Cargo.lock";
              outputHashes = {
                "isakmp-0.1.0" = "sha256-ucF1D1frzZ3By8kn1yj+SBFfwiLvpTUKXf/sl3dt564=";
              };
            };

            nativeBuildInputs = with pkgs; [
              pkg-config
              rustc
              cargo
            ];

            buildInputs = with pkgs; [
              openssl
              dbus
              gtk4
            ];
          };
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              self.formatter.${system}

              openssh
              git

              snx-rs-v4

              direnv
              rsync
            ];

            shellHook = ''
              echo "  Direnv ativo neste shell"
              echo "  Ambiente de trabalho ativo"

              if [ -z "$SSH_AUTH_SOCK" ]; then
                eval "$(ssh-agent -s)" > /dev/null
                echo "🔑 ssh-agent iniciado"
              fi

              mkdir -p workspace/part{1,2,3,4}
              mkdir -p workspace/isoimages
            '';
          };
        });

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
