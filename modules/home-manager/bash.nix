{ pkgs, ... }:

{

  programs.bash = {
    enable = true; 
    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake ~/nixos-config";
      rate = "xrandr --output HDMI-0 --mode 1920x1080 --rate 75";
      server = "ssh archvisions@192.168.12.117";
    };
  };
}