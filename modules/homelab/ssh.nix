{ pkgs, ... }:

{
  # Allow SSH through firewall
  networking.firewall.allowedTCPPorts = [ 22 ];
  
  # SSH config
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
      openFirewall = true;
    };
  };
}
