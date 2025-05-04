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

    # MacOS/Darwin Stuff

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
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
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      ...
    }:
    {

      nixosConfigurations = {
        YDdraigGoch = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./system/nixos.nix
            ./system/hosts/YDraigGoch/configuration.nix
            ./system/hosts/YDraigGoch/hardware-configuration.nix
          ];
        };

        WinterDragon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            ./system/nixos.nix
            ./system/hosts/WinterDragon/configuration.nix
            ./system/hosts/WinterDragon/hardware-configuration.nix
          ];
        };
      };

      darwinConfigurations = {
        "mb-H02L4YFQ6P" = nix-darwin.lib.darwinSystem {
          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = "mika.zimina";
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                autoMigrate = true;
              };
            }
            ./system/darwin.nix
            ./system/hosts/WorkerBee/configuration.nix
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
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/YDdraigGoch.nix
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
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/WinterDragon.nix
          ];
        };
      };
    };
}
