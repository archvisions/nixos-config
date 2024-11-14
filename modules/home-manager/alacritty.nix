{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    catppuccin = { 
      enable = true;
      flavor = "mocha";
    };
  };
}
