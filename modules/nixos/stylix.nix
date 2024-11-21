{ pkgs, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    autoEnable = true;
    image = ../../nixos/zion/background.png;
    opacity.terminal = 0.75;
    fonts = {
      sansSerif = {
        name = "Inter";
        package = pkgs.inter;
      };
      serif = {
        name = "Inter";
        package = pkgs.inter;
      };
      monospace = {
        name = "Fira Code";
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
      };
    };
  };
}
