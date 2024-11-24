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

        vw.archvisions.xyz {
          import tls
          reverse_proxy localhost:8000
        }

        rss.archvisions.xyz {
          import tls
          reverse_proxy localhost:9010
        }

        nc.archvisions.xyz {
          import tls
          reverse_proxy localhost:8080
        }

        media.archvisions.xyz {
          import tls
          reverse_proxy localhost:8096
        }

        deluge.archvisions.xyz {
          import tls
          reverse_proxy localhost:8111
        }

        yt.archvisions.xyz {
          import tls
          reverse_proxy localhost:3000
        }
    '';
  };
}
