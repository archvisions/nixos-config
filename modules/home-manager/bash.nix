{ pkgs, ... }:

{

  programs.bash = {
    enable = true; 
    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake ~/nixos-config/flake.nix";
    };
  };
}
