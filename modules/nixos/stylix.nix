{ pkgs, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    autoEnable = true;
  };
  stylix.image = ../../nixos/zion/wallpaper.png;
}
