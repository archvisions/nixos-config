{ config, pkgs, ... }:

{
  home.username = "archvisions";
  home.homeDirectory = "/home/archvisions";

  imports = [
    ../../modules/home-manager
  ]; 
  
  home.packages = with pkgs; [
   yazi
   gh
   git
   xorg.xinit
   alacritty
   dmenu
   mullvad-browser
   nwg-look
   tor-browser
   htop
   bitwarden-desktop
   joplin-desktop
   prismlauncher
   pamixer
   brave
   brightnessctl   
  ]; 

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

