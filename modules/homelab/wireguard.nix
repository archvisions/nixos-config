{ pkgs, config, ... }:

{
  sops.secrets = {
    wireguard_priv = {
      sopsFile = ../../secrets/secrets.yaml;
    };
  };

  networking = {
    nat.internalInterfaces = [ "wg0" ];
    firewall.allowedUDPPorts = [ 51820 ];

  wireguard.interfaces.wg0 = {
    ips = [ "10.10.2.2" ];
    listenPort = 51820;
    postSetup = ''
      ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT; ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o enp0s20f0u1 -j MASQUERADE
    '';
    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT; ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -o ens18 -j MASQUERADE
    '';
    privateKeyFile = config.sops.secrets.wireguard_priv.path;

    peers = [
        {
          # Server
          publicKey = "zFi/22a5oc1y5Fku2cN+lDS936/LZEDIlvLOuHY56Tk=";
          allowedIPs = [ "10.10.2.0/24" ];
          endpoint = "172.234.219.141:51820";
          persistentKeepalive = 25;

    }
   ];
  };
 };
}
