{ config, pkgs, ... }:

{
  users.groups.nas = {};
  users.users.nextcloud.extraGroups = [ "nas" ];

  sops.secrets.nextcloud = {
    sopsFile = ../../secrets/secrets.yaml;
    owner = "nextcloud";
    group = "nextcloud";
  };

  services = {
    nginx.virtualHosts = {
      "nc.archvisions.xyz" = {
        forceSSL = false;
        enableACME = false;
        listen = [ { addr = "127.0.0.1"; port = 8080; } ];
      };
    };

    nextcloud = {
      enable = true;
      
      hostName = "nc.archvisions.xyz";

      package = pkgs.nextcloud30;

      database.createLocally = true;

      configureRedis = true;

      maxUploadSize = "8G";
      https = true;

      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        inherit calendar contacts notes tasks;

        news = pkgs.fetchNextcloudApp rec {
          url = "https://github.com/nextcloud/news/releases/download/25.0.0-alpha14/news.tar.gz";
          sha256 = "sha256-6A6tUD14hEo51es0Egn0Bk1RZjXjW1KSq/Mk3P0C/Xw=";
          license = "gpl3";
        };

      };

      settings.overwriteprotocol = "https";
      config = {
        dbtype = "pgsql";
        adminuser = "archvisions";
        adminpassFile = config.sops.secrets.nextcloud.path;
      };
    };
  };
}
