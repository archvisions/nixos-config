{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  fileSystems."/export/nas" = {
    device = "/nas";
    options = [ "bind" ];
  };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export         192.168.12.170(rw,fsid=0,no_subtree_check)
    /export/nas  192.168.12.170(rw,nohide,insecure,no_subtree_check)
  '';
}
