{
  description = "bwabwabwa bwabwabwa bwabwabwaaaa";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgsUnstable, home-manager, nix-colors, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      unstablePkgs = import nixpkgsUnstable { system = system; config.allowUnfree = true; };

    in {
      nixosConfigurations.mami = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/mami/configuration.nix
          ./system/mami/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.dumbcirno = {
              imports = [ ./home/mami/default.nix ];
            };
            home-manager.extraSpecialArgs = {
              inherit nix-colors;
            };
          }
        ];
      };
    };
}
