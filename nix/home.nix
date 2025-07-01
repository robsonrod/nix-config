{ config, pkgs, inputs, ... }:
{

  programs = {
   home-manager.enable = true;
  };

  git.enable = true;
  cliapps.enable = true;

  emacs.enable = true;
  gpg.enable = true;
  zathura.enable = true;
  peek.enable = true;
  kitty.enable = true;

   nix = {
    package = pkgs.nix;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';

  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
