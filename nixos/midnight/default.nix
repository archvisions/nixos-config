{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/homelab/default.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "midnight";

  time.timeZone = "America/Chicago";

  users.users.archvisions = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     packages = with pkgs; [
       tmux
       cryptsetup
       restic
       git
    ];
   };

  networking.firewall.enable = true;
  system.stateVersion = "24.05";

}
