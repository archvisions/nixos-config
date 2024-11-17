{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/default.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Overlay Blender
  nixpkgs.overlays = [ inputs.blender-bin.overlays.default ];

  # Networking
  networking.hostName = "zion";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "192.168.12.117" ];

  services.mullvad-vpn.enable = true; 
  # Allow Unfree repo
  nixpkgs.config.allowUnfree = true;

  # Time
  time.timeZone = "America/Chicago";
  time.hardwareClockInLocalTime = true;
 
  # Fix Gnome Pinentry
  services.dbus.packages = [ pkgs.gcr ];
 
  # Locales
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Xorg server
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.libinput.enable = true;
  services.xserver.dpi = 81;  

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
      rev = "6d482dec02b5f71177bf5b646359849650ff9cfd";
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
    ntfs3g
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 443 80 ];

  system.stateVersion = "24.05";

}

