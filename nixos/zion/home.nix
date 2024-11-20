{ config, pkgs, inputs, ... }:

{
  home.username = "archvisions";
  home.homeDirectory = "/home/archvisions";

  imports = [
    ../../modules/home-manager
  ]; 
  
  home.packages = with pkgs; [
   gh
   git
   (retroarch.override {
    cores = with libretro; [
      mesen
    ];
   })
   blender_4_2
   xorg.xinit
   iotas
   signal-desktop
   restic
   (nerdfonts.override { fonts = [ "FiraCode" ]; })
   networkmanagerapplet
   adwaita-icon-theme
   inter
   dmenu
   feh
   mullvad-browser
   tor-browser
   htop
   bitwarden-desktop
   prismlauncher
   pamixer
   brave
   fira-code
   thunderbird
   brightnessctl   
   # Slstatus Override
   (slstatus.overrideAttrs (_: { src = fetchGit {
     url = https://github.com/archvisions/slstatus_dwm.git;
     ref = "master";
     rev = "6cb463d41646e56cc6eb2feb13aabb85f5f955a4";
    };
   }))
  ]; 

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Inter" ];
      serif = [ "Inter" ]; 
    };  
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

