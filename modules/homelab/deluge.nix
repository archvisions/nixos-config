{ pkgs, config, ... }:

{
  sops.secrets = {
    deluge = {
      sopsFile = ../../secrets/secrets.yaml;
        owner = "deluge";
        group = "deluge";
    };
  };

  services.deluge = {
    enable = true;
    declarative = true;
    openFirewall = true;
    authFile = config.sops.secrets.deluge.path;
    web = {
      enable = true;
      openFirewall = false;
      port = 8111;
    };
  };
}
