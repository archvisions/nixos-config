{ pkgs, config, ...}:

{
  sops.secrets = {
    vaultwarden_user = {
    sopsFile = ../../secrets/secrets.yaml;
    owner = config.users.users.vaultwarden.name;
    };

    vaultwarden_pass = {
    sopsFile = ../../secrets/secrets.yaml;
    owner = config.users.users.vaultwarden.name;
    };
    
    vaultwarden_from = {
    sopsFile = ../../secrets/secrets.yaml;
    owner = config.users.users.vaultwarden.name;
    };

    vaultwarden_mail = {
    sopsFile = ../../secrets/secrets.yaml;
    owner = config.users.users.vaultwarden.name;
    };
  };

  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://vw.archvisions.xyz";
      SIGNUPS_ALLOWED = true;
      PUSH_ENABLED = false;
      SENDS_ALLOWED = true;
      INVITATIONS_ALLOWED = false;
      WEB_VAULT_ENABLED = true;
      SIGNUPS_VERIFY = true;
      SIGNUPS_VERIFY_RESEND_TIME = 3600;
      SIGNUPS_VERIFY_RESEND_LIMIT = 3;
      EMERGENCY_ACCESS_ALLOWED = false;
      SMTP_HOST_FILE = config.sops.secrets.vaultwarden_mail.path ;
      SMTP_FROM_NAME = "Vault";
      SMTP_FROM_FILE = config.sops.secrets.vaultwarden_from.path;
      SMTP_USERNAME_FILE = config.sops.secrets.vaultwarden_user.path;
      SMTP_PASSWORD_FILE = config.sops.secrets.vaultwarden_pass.path;
      SMTP_SECURITY = "force_tls";
      SMTP_PORT = 465;
      SMTP_AUTH_MECHANISM = "Plain";
      SMTP_EMBED_IMAGES = false;
    };
  };
}
