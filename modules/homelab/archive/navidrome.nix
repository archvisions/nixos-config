{ pkgs, config, ... }:

{
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/nas/music";
    };
  };
}
