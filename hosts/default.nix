{ inputs, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, home-manager-stable, vars, home-modules, ... }:
let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable vars;
    };
    modules = [
      ./vm
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = inputs;
          users.robson = {
            imports = [
              ./vm/home.nix
              home-modules
            ];
          };
        };
      }
    ];
  };


  xps = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable vars;
    };
    modules = [
      ./xps
      nixos-hardware.nixosModules.common-pc-laptop
      nixos-hardware.nixosModules.common-pc-laptop-ssd
      nixos-hardware.nixosModules.common-cpu-intel
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = inputs;
          users.robson = {
            imports = [
              ./vm/home.nix
              home-modules
            ];
          };
        };
      }
    ];
  };

}
