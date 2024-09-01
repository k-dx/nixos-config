{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs?rev=5fc085988400e9723b81b5d13423bb8ed030334d";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
        ./configuration.nix
        # inputs.home-manager.nixosModules.default
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # TODO replace ryan with your own username
          home-manager.users.kuba = import ./home.nix;
        }
      ];
    };
  };
}
