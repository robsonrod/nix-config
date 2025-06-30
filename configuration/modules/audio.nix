{ config, pkgs, inputs, ... }:
{
services = {
pulseaudio = { enable = false; };
pipewire = {
      audio.enable = true;
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

};

}