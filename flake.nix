{
  description = "Mika Drakolis NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      nix-yazi-plugins,
      nix-vscode-extensions,
      sops-nix,
      nix-darwin,
      ...
    }:
    {

      nixosConfigurations = {
        YDdraigGoch = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./system/nixos.nix
            ./hosts/YDdraigGoch/configuration.nix
            ./hosts/YDdraigGoch/hardware-configuration.nix
          ];
        };

        WinterDragon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./system/nixos.nix
            ./hosts/WinterDragon/configuration.nix
            ./hosts/WinterDragon/hardware-configuration.nix
          ];
        };
      };

      darwinConfigurations = {
        "mb-H02L4YFQ6P" = nix-darwin.lib.darwinSystem {
          modules = [
            ./system/darwin.nix
            ./hosts/WorkerBee/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "drakolis@YDdraigGoch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            plasma-manager.homeManagerModules.plasma-manager
            ./home-manager/drakolis.nix
          ];
        };

        "drakolis@WinterDragon" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            plasma-manager.homeManagerModules.plasma-manager
            ./home-manager/drakolisHypr.nix
          ];
        };
      };
    };
}
