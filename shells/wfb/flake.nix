{
  description = "A Nix-flake-based to my work environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, ... }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forEachSupportedSystem =
        f: inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              self.formatter.${system}
              openssh
              git
              direnv
              rsync
              tmux
            ];

            shellHook = ''
              cleanup() {
                rm -rf "$WORKSPACE_DIR"
              }

              export PROJECT_ROOT="$PWD"
              export WORKSPACE_DIR="$PWD/.workspace"
              mkdir -vp "$WORKSPACE_DIR"

              echo "  Direnv ativo neste shell"
              echo "  Ambiente de trabalho ativo: $WORKSPACE_DIR"

              if [ -z "$SSH_AUTH_SOCK" ]; then
                eval "$(ssh-agent -s)" > /dev/null
                echo "🔑 ssh-agent iniciado"
              fi

            '';

          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
