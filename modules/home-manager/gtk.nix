{ pkgs, ... }:

{
  home.packages = [ pkgs.dconf ];
  gtk = {
    enable = true;
  };
}
