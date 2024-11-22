{ pkgs, ... }:

{

  programs.zsh = {
    enable = true; 
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#cac9c9";
    };

    initExtra = "microfetch";

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "gozilla";
    };

    history = {
      size = 10000;
    };
 
    shellAliases = {
      ns = "sudo nixos-rebuild switch --flake ~/nixos-config";
      rate = "xrandr --output HDMI-0 --mode 1920x1080 --rate 75";
      server = "ssh archvisions@192.168.12.117";

    };
  };
}
