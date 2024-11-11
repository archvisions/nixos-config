{ inputs, config, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yml;
    age = {
      keyFile = "/var/lib/sops/age/keys.txt";
    };
  };
}
