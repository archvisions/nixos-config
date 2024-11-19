{ pkgs, ... }:

{

# Allow Blocky through Firewall 
networking.firewall.allowedTCPPorts = [ 53 ];
networking.firewall.allowedUDPPorts = [ 53 ];

# Logs Directory for Blocky
systemd.services.blocky.serviceConfig.LogsDirectory = [ "blocky" ];

# Blocky Config
services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;
      upstreams = {
        strategy = "parallel_best";
        groups.default = [
          "https://dns.quad9.net/dns-query"
          "https://dns.mullvad.net/dns-query"
          "https://dns.nextdns.io"
        ];
      };
      bootstrapDns = {
        upstream = [ "https://dns.quad9.net/dns-query" "https://dns.mullvad.net/dns-query" "https://dns.nextdns.io" ];
        ips = [ "9.9.9.9" ];
      };
      customDNS = {
        customTTL = "1h";
        filterUnmappedTypes = true;
        mapping = {
          "archvisions.xyz" = "192.168.12.117";
        };
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
        prefetchExpires = "1h";
      };
      queryLog = {
        type = "csv";
        target = "/var/log/blocky/queries";
        logRetentionDays = 1;
      };
      # Blocking
      blocking = {
        clientGroupsBlock = {
        default = [ "ads" "no_fam" "tracking" ];
        };
        denylists = {
          ads = [
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          "https://someonewhocares.org/hosts/zero/hosts"
          "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/ultimate.txt"
          "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
          ];
          no_fam = [
          "https://raw.githubusercontent.com/anudeepND/blacklist/master/facebook.txt"
          "https://raw.githubusercontent.com/nickspaargaren/no-amazon/refs/heads/master/amazon.txt"
          "https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/microsoft/all"
          ];
          less_agressive = [
          "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.plus.txt"
          "https://raw.githubusercontent.com/anudeepND/blacklist/master/facebook.txt"
          "https://phishing.army/download/phishing_army_blocklist_extended.txt"
          ];
          tracking = [
          (pkgs.writeText "blacklist.txt" ''
            *.msftconnecttest.com
            *.samsung.com
            *.samsungdm.com
            *.samsungcloud.com
            *.secb2b.com

          '')
          ];
        };
        allowlists = {
          no_gafam = [
          (pkgs.writeText "whitelist.txt" ''
            storage.signal.org
          '')
          ];
        };
      loading = {
        refreshPeriod = "6h";
        strategy = "blocking";
        downloads = {
          timeout = "10m";
          attempts = 5;
          cooldown = "3s";
          };
        };
      };
    };
  };
}
