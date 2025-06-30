{ config, options, lib, pkgs, inputs, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      allowed-users = [ "robson" ];
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
    #      overlays = [
    #        inputs.emacs-overlay.overlay
    #        inputs.neovim-nightly-overlay.overlays.default
    #        inputs.rust-overlay.overlays.default
    #      ];
  };
}
