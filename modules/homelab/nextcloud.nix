{ config, lib, pkgs, ... }:

{
    nextcloud = {
      enable = true;
      hostName = "cloud.example.com";

      package = pkgs.nextcloud30;

      database.createLocally = true;

      configureRedis = true;

      maxUploadSize = "8G";
      https = true;
      enableBrokenCiphersForSSE = false;

      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {

        inherit calendar contacts mail notes tasks;

        };
      };

      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "PT";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/path/to/nextcloud-admin-pass";
      };
    };
  };
}
