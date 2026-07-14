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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
    };
  };
  outputs = { nixpkgs, nixpkgsUnstable, home-manager, nix-colors, niri, walker, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      unstablePkgs = import nixpkgsUnstable { system = system; config.allowUnfree = true; };

      linuxUnstablePkgs = import nixpkgsUnstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.mami = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit linuxUnstablePkgs;
        };
        modules = [
          ./system/mami/configuration.nix
          ./system/mami/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            # Only the HM config module — not nixosModules.niri, which adds niri.cachix.org.
            home-manager.sharedModules = [
              niri.homeModules.config
              walker.homeManagerModules.default
              (
                { lib, ... }:
                {
                  programs.niri.package = lib.mkForce linuxUnstablePkgs.niri;
                }
              )
            ];
            home-manager.users.dumbcirno = {
              imports = [ ./home/mami/default.nix ];
            };
            home-manager.extraSpecialArgs = {
              inherit nix-colors linuxUnstablePkgs;
            };
          }
        ];
      };
    };
}
