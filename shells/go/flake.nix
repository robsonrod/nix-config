{
  description = "Go lang development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gomod2nix.url = "github:tweag/gomod2nix";

  };

  outputs = { self, nixpkgs, flake-utils, gomod2nix, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ gomod2nix.overlays.default ];
        };
        inputs = with pkgs; [
          go
          gopls
          gotools
          go-tools
          gomod2nix.packages.${system}.default
          sqlite-interactive
        ];
      in
      with pkgs;
      {
        packages.default = pkgs.buildGoApplication {
          pname = "urutau";
          version = "0.1.0-beta";

          src = ./.;
          modules = ./gomod2nix.toml;
          enableCGO = true;

          ldflags = [
            "-s"
            "-w"
            "-X main.Version=${self.packages.${system}.default.version}"
          ];

          meta = with pkgs.lib; {
            description = "Minimal CLI tool for listing jira issues";
            homepage = "https://github.com/";
            license = licenses.mit;
            mainProgram = "urutau";
          };
        };
        devShells.default = mkShell
          {
            name = "go lang";
            packages = inputs;
          };
      });
}
