{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;

let
  cfg = config.stumpwm;
in
{

    options.stumpwm = {

    enable = mkOption {
      type = bool;
      default = false;
    };

  };
  
  config = mkIf cfg.enable {
 
  home.packages = with pkgs; [
    sbcl
    stumpwm
    rlwrap
  ];


  # xsession.windowManager.command = "exec stumpwm";

   #home.file.".stumpwmrc".source = ../../dotfiles/stumpwm/.config/stumpwm/ /stumpwm/config.lisp;

   };
}
