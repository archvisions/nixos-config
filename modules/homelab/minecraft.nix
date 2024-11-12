{ pkgs, lib, inputs, ... }:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "minecraft-server"
  ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    
    servers = {
      minecraft-minigame = {
        enable = true;

        package = pkgs.paperServers.paper-1_21_3;

        serverProperties = {
          "max-players" = 4;
          "gamemode" = "survival";
          "online-mode" = false;
          "enable-command-block" = false;
          "log-ips" = false;
          "motd" = "ArchVisions' Minigame server";
          "view-distance" = 10;
          "server-port" = 25565;
          "ops" = "archvisions";
        };

        symlinks = {
          "plugins/SkinsRestorer.jar" = pkgs.fetchurl rec {
            pname = "SkinsRestorer";
            version = "15.4.4";
            url = "https://github.com/${pname}/${pname}/releases/download/${version}/${pname}.jar";
            hash = "sha256-Dc/yZW5CsWU596+sGV5mWqOVeg4+QTNt5FM3yH7vsLw=";
          };  
        };

        jvmOpts = "-Xms4096M -Xmx4096M";
      };
    };
  };
}
