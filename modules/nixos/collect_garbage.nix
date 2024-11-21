{ pkgs, ... }:

{
  nix = {
    optimise.automatic = true;
    gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
    };
  };
}
