{ config, pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    fade = true;
    fadeSteps = [
      0.07
      0.07
    ];
  };
} 
