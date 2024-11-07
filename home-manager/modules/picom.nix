{ pkgs, inputs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
  };
} 
