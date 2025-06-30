{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.vscode;
in
{
  options.vscode = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      vscode = {
        enable = true;
	extensions = with pkgs.vscode-extensions; [
        formulahendry.code-runner
	ms-python.python
	bbenoist.Nix
        ms-vscode.cpptools-extension-pack
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [];
      };
    };

  };

}