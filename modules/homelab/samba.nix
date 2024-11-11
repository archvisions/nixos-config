{ pkgs, ... }:
{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smb";
        "netbios name" = "smb";
        "security" = "user";
        "hosts allow" = "192.168.12. 10.10.2. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
    };
      "nas" = {
        "path" = "/nas";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "archvisions";
      };
    };
  };
 
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
