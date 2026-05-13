{
  description = "Work dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            openssh
            git
            jq
            snx-rs
            direnv
          ];

          shellHook = ''
            echo "🚀 Ambiente de trabalho ativo"

            if [ -z "$SSH_AUTH_SOCK" ]; then
              eval "$(ssh-agent -s)" > /dev/null
              echo "🔑 ssh-agent iniciado"
            fi

            alias vpn-up="snx"
            alias vpn-down="snx -d"

            echo "👉 VPN: vpn-up / vpn-down"
            echo "👉 Direnv ativo neste shell"
          '';
        };
      });
}
