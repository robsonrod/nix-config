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
              snx-rs
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
               trap 'echo " Faxina do ambiente de trabalho agendada" && rm -rf /tmp/workspace/*' EXIT
            '';

          };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
