{ config, pkgs, inputs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        devices = [ "nodev" ];
        configurationLimit = 5;
        gfxmodeEfi = "1920x1080x32";

        theme = pkgs.stdenv.mkDerivation {
          pname = "nix-gruv-grub";
          version = "1";
          src = pkgs.fetchFromGitHub {
            owner = "robsonrod";
            repo = "nix-gruv-grub";
            rev = "269507de98ecd4fd9c57aa06bf5d8132d6949a06";
            hash = "sha256-UEPZxyT09Z0PiOka/Dh4m8VvqF4l+01eZVbRkPJduDk=";
          };
          installPhase = "cp -r tartarus/ $out";
        };
      };
    };
  };

}
