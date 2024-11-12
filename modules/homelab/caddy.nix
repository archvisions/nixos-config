{ pkgs, config, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.caddy = {
  enable = true; # Working on configuration...
      configFile = pkgs.writeText "Caddyfile" ''
        (tls) {
          tls /var/lib/caddy/archvisions.xyz/fullchain.cer /var/lib/caddy/archvisions.xyz/archvisions.xyz.key
        }

        music.archvisions.xyz {
          import tls
          reverse_proxy localhost:4533
        }

        nc.archvisions.xyz {
          import tls
          redir /.well-known/carddav /remote.php/dav/ 301
          redir /.well-known/caldav /remote.php/dav/ 301
          reverse_proxy localhost:8080
        }
        
        vw.archvisions.xyz {
          import tls
          reverse_proxy localhost:8000
        }
    '';
  };
}
