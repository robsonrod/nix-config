{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, home-manager-stable, ... }:
    let
     vars = {
       user = "robson";
       terminal = "kitty";
       editor = "emacs";
     };
     home-modules = ./home;
    in
    {
      nixosConfigurations = (
        import ./hosts {
	    inherit (nixpkgs) lib;
	    inherit inputs nixpkgs nixpkgs-stable nixos-hardware home-manager home-manager-stable vars home-modules;
	}
      );

      homeConfigurations = (
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager vars;
        }
      );
    };
}
