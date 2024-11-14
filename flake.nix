{
  description = "nixos-config";

  inputs = {

    nixpkgs = { 
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
    };

    catppuccin.url = {
      "github:catppuccin/nix";
    };

  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {

    nixosConfigurations = {

      zion = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/zion/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = { 
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.archvisions = { 
              imports = [ 
                ./nixos/zion/home.nix
                inputs.catppuccin.homeManagerModules.catppuccin
                ];
              };
            };
          }
        ];
      };
      
      midnight = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/midnight/default.nix
        ];
      };
    };
  };
}
