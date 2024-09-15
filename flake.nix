{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs?rev=7ad7b570e96a3fd877e5fb08b843d66a30428f12";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos = let
        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      in nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit pkgs-unstable;};
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./hosts/nixos/configuration.nix
        # inputs.home-manager.nixosModules.default
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.kuba = import ./hosts/nixos/home.nix;
        }
      ];
    };
    nixosConfigurations.nixos-kde = let
        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      in nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit pkgs-unstable;};
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./hosts/nixos-kde/configuration.nix
        # inputs.home-manager.nixosModules.default
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];

          home-manager.users.kuba = import ./hosts/nixos-kde/home.nix;
        }
      ];
    };
  };
}
