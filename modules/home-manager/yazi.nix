{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    catppuccin = {
      enable = true;
      accent = "lavender";
      flavor = "mocha";
    };
  };
}
