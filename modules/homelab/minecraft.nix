{ pkgs, lib, inputs, ...}:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    
    servers = {
      minecraft-minigame = {
        enable = true;
        
        packages = paperServers.paper-1.21.3;

         symlinks = {
           plugins = pkgs.linkFarmFromDrvs "plugins" (builtins.attrValues {
           SkinsRestorer = fetchurl { url = "https://github.com/SkinsRestorer/SkinsRestorer/releases/download/15.4.4/SkinsRestorer.jar"; sha512 = ""; };
             });
           };
         }
        serverProperties = {
          "max-players" = 4;
          "gamemode" = "survival";
          "online-mode" = false;
          "enable-command-block" = false;
          "log-ips" = false;
          "motd" = "ArchVisions' Minigame server";
          "view-distance" = 10;
          "server-port" = 25565;
        };

        jvmOpts = "-Xms4096M -Xmx4096M";
      };
   };
}
