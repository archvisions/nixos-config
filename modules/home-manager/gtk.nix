{ pkgs, ... }:

{
  home.packages = [ pkgs.dconf ];
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      accent = "lavender";
      flavor = "mocha";
    };
  };
}
