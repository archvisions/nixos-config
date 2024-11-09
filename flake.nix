{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations =
      let
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
      in
      {
      
      zion = nixpkgs.lib.nixosSystem {
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
        modules = [
          ./nixos/midnight/default.nix
        ];
      };

    };
  };
}
