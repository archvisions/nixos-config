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
   (slstatus.overrideAttrs (_: { src = fetchGit {
     url = https://github.com/archvisions/slstatus_dwm.git;
     ref = "master";
     rev = "6cb463d41646e56cc6eb2feb13aabb85f5f955a4";
    };
   }))
  ]; 

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

