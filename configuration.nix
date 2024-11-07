{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.wireless.iwd.enable = true;
  networking.nameservers = [ "192.168.12.60" ];
 
  # Time
  time.timeZone = "America/Chicago";
  time.hardwareClockInLocalTime = true;
  
  # Locales
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Xorg server
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.libinput.enable = true;
  
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
 
  # Add user packages and user archvisions
  users.users.archvisions = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     packages = with pkgs; [
     git 
     fira-code
     xorg.xinit
     alacritty
     dmenu
     mullvad-browser
     nwg-look
     tor-browser
     htop
     bitwarden-desktop
     joplin-desktop
     (slstatus.overrideAttrs (_: { src = /home/archvisions/slstatus; })) 
#     blender # Blender is currently broken
     prismlauncher
     pamixer
     brave
     brightnessctl
    ];
   };
  
  # Enable DWM
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = fetchGit {
      url = "https://codeberg.org/firedragon/firedragon-dwm.git";
      ref = "main";
      rev = "710be6f3308fe5014829c4ed59248ef208c29150";
    };
    nativeBuildInputs = with pkgs; [
      xorg.libX11
      xorg.libXft
      imlib2
      xorg.libXinerama
    ];
  };
  # Enable Picom
  services.picom = {
    enable = true;
    backend = "glx";
  };
  # System packages
  environment.systemPackages = with pkgs; [
    wget
    vim
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 443 80 ];

  system.stateVersion = "24.05";

}

