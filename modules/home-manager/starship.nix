{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
