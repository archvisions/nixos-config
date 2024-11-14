{ pkgs, config, ... }:

{
  sops.secrets = {
    miniflux = {
    sopsFile = ../../secrets/secrets.yaml;
    };
  };

  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.sops.secrets.miniflux.path;
    config = {
      "LISTEN_ADDR" = "127.0.0.1:9010";
      "CREATE_ADMIN" = 1;
    };
  };
}
