{ inputs, nixpkgs, home-manager, vars, home-modules, ... }:

let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in
{
  nonos = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs vars; };
    modules = [
      ./home.nix
      home-modules
      {
        home = {
          username = "${vars.user}";
          homeDirectory = "/home/${vars.user}";
          packages = [ pkgs.home-manager ];
          stateVersion = "25.05";
        };
      }
    ];
  };
}
