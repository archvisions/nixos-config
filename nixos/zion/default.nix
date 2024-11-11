{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/default.nix
      ../../modules/sops.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "zion";
  networking.wireless.iwd.enable = true;
  networking.nameservers = [ "192.168.12.117" ];
 
  # Allow Unfree repo
  nixpkgs.config.allowUnfree = true;

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
   };
  
  # Enable DWM
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = fetchGit {
      url = "https://github.com/archvisions/archvisions-dwm.git";
      ref = "master";
      rev = "9f82e80380b6f4ceeff073cb230adea4f24272f5";
    };
    nativeBuildInputs = with pkgs; [
      xorg.libX11
      xorg.libXft
      imlib2
      xorg.libXinerama
    ];
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

