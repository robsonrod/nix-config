{ config, options, lib, pkgs, inputs, vars, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      allowed-users = [ "${vars.user}" ];
      trusted-users = [ "root" "@wheel" ];
      keep-outputs = true;
      auto-optimise-store = true;
      keep-derivations = true;
      max-jobs = lib.mkDefault 10;
    };
    optimise.automatic = true;
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };
}
