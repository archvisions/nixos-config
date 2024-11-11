{ config, pkgs, ... }:

{
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
        inherit calendar contacts mail notes tasks;
      };

      config = {
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = config.sops.secrets.nextcloud.path;
      };
    };
  };
}
