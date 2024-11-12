{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [ nfs-utils ];

  fileSystems."/home/archvisions/nas" = {
    device ="192.168.12.117:/nas";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
}
