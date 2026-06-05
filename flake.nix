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

    neovim-config = {
      url = "git+https://codeberg.org/robsonrod/nvim";
      flake = false;
    };


  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, home-manager-stable, neovim-config, ... }:
    let
      vars = rec {
        user = "robson";
        terminal = "ghostty";
        editor = "nvim";
        dotfiles = ./dotfiles;

        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          stateVersion = "26.05";
        };
      };
      home-modules = ./home-manager;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable nixos-hardware home-manager home-manager-stable vars home-modules neovim-config;
        }
      );

      homeConfigurations = (
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager vars home-modules;
        }
      );
    };

  nixConfig = {
    extra-substituters = [
      "https://nixpkgs.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
    ];
  };
}
