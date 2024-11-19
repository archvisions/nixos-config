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

  # Set Default Shell as ZSH
  programs.zsh.enable = true;

  # Mullvad VPN
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

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
 
  # Add user packages and user archvisions
  users.users.archvisions = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ "wheel" ];
   };
  
  # System packages
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 443 80 ];

  system.stateVersion = "24.05";

}

