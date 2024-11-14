{ pkgs, ... }:

{
  services.dunst = { 
    enable = true; 
    catppuccin = {
      enable = true;
      flavor = "mocha";
    };
  };
}
