{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    fade = true;
    settings = {
      blur-method = "dual_kawase";
      blur-strength = 4;
    };
    fadeSteps = [
      0.07
      0.07
    ];
  };
} 
