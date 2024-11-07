{ config, pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
  };
} 
