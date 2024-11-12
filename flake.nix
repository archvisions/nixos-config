{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = inputs@{ nixpkgs, home-manager, sops-nix, ... }: {
    nixosConfigurations =
      let
        system = "x86_64-linux";
      in
      {
      
      zion = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/zion/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.archvisions = import ./nixos/zion/home.nix;
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
