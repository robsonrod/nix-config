{ inputs, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, home-manager-stable, vars, home-modules, ... }:

let
  lib = nixpkgs.lib;

  mkHost =
    { system
    , host
    , home
    , homeStateVersion
    , hardware ? [ ]
    ,
    }:
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs system vars;

        stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };

      modules =
        [
          host
          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bkp";

              extraSpecialArgs = {
                inherit inputs vars;
              };

              users.robson = {
                home.stateVersion = homeStateVersion;
                imports = [
                  home
                  home-modules
                ];
              };
            };
          }
        ]
        ++ hardware;
    };
in
{
  vm = mkHost {
    system = "x86_64-linux";
    host = ./vm;
    home = ./vm/home.nix;
    homeStateVersion = "26.05";
  };

  acrux = mkHost {
    system = "x86_64-linux";
    host = ./acrux;
    home = ./acrux/home;
    homeStateVersion = "26.05";
    hardware = [
      nixos-hardware.nixosModules.common-pc-laptop
      nixos-hardware.nixosModules.common-pc-laptop-ssd
      nixos-hardware.nixosModules.common-cpu-intel
    ];
  };

  canopus = mkHost {
    system = "aarch64-linux";
    host = ./canopus;
    home = ./canopus/home;
    homeStateVersion = "26.05";
    hardware = [
      nixos-hardware.nixosModules.raspberry-pi-5
    ];
  };
}
