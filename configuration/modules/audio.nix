{ config, pkgs, stable, inputs, ... }:
{
  services = {
    pulseaudio = { enable = false; };
    pipewire = {
      package = stable.pipewire;
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
