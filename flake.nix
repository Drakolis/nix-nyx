{
  description = "Mika Drakolis NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Linux stuff

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    niri-flake.url = "github:sodiboo/niri-flake";

    niri-screen-time = {
      url = "github:probeldev/niri-screen-time";
    };

    niri-session-manager.url = "github:MTeaHead/niri-session-manager";

    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS/Darwin Stuff

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
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
    inputs@{
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      niri-flake,
      niri-session-manager,
      nix-yazi-plugins,
      nix-vscode-extensions,
      sops-nix,
      nix-darwin,
      mac-app-util,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      ...
    }:
    {
      nixosConfigurations = {
        Joermungandr = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            niri-session-manager.nixosModules.niri-session-manager
            ./system/nixos.nix
            ./system/hosts/Joermungandr/configuration.nix
            ./system/hosts/Joermungandr/hardware-configuration.nix
            ./system/users/drakolis.nix
          ];
        };

        YDdraigGoch = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            niri-session-manager.nixosModules.niri-session-manager
            ./system/nixos.nix
            ./system/hosts/YDdraigGoch/configuration.nix
            ./system/hosts/YDdraigGoch/hardware-configuration.nix
            ./system/users/drakolis.nix
            ./system/users/neinhorn.nix
          ];
        };

        Quetzalcoatl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            niri-session-manager.nixosModules.niri-session-manager
            ./system/nixos.nix
            ./system/hosts/Quetzalcoatl/configuration.nix
            ./system/hosts/Quetzalcoatl/hardware-configuration.nix
            ./system/users/drakolis.nix
          ];
        };

        WinterDragon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            niri-session-manager.nixosModules.niri-session-manager
            ./system/nixos.nix
            ./system/hosts/WinterDragon/configuration.nix
            ./system/hosts/WinterDragon/hardware-configuration.nix
            ./system/users/drakolis.nix
          ];
        };
      };

      darwinConfigurations = {
        "mb-H02L4YFQ6P" = nix-darwin.lib.darwinSystem {
          modules = [
            mac-app-util.darwinModules.default
            nix-homebrew.darwinModules.nix-homebrew
            {
              nixpkgs.config.allowBroken = true;
              system.primaryUser = "mika.zimina";
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

        "SilverWing" = nix-darwin.lib.darwinSystem {
          modules = [
            mac-app-util.darwinModules.default
            nix-homebrew.darwinModules.nix-homebrew
            {
              nixpkgs.config.allowBroken = true;
              system.primaryUser = "drakolis";
              nix-homebrew = {
                user = "drakolis";
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
            ./system/hosts/SilverWing/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "drakolis@Joermungandr" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            plasma-manager.homeModules.plasma-manager
            niri-flake.homeModules.niri
            inputs.ignis.homeManagerModules.default
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/Joermungandr.nix
          ];
        };

        "drakolis@YDdraigGoch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            plasma-manager.homeModules.plasma-manager
            niri-flake.homeModules.niri
            inputs.ignis.homeManagerModules.default
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/YDdraigGoch.nix
          ];
        };

        "neinhorn@YDdraigGoch" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            plasma-manager.homeModules.plasma-manager
            niri-flake.homeModules.niri
            inputs.ignis.homeManagerModules.default
            ./home-manager/users/neinhorn.nix
            ./home-manager/hosts/YDdraigGoch.nix
          ];
        };

        "drakolis@WinterDragon" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            plasma-manager.homeModules.plasma-manager
            niri-flake.homeModules.niri
            inputs.ignis.homeManagerModules.default
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/WinterDragon.nix
          ];
        };

        "drakolis@Quetzalcoatl" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            plasma-manager.homeModules.plasma-manager
            niri-flake.homeModules.niri
            inputs.ignis.homeManagerModules.default
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/Quetzalcoatl.nix
          ];
        };

        "drakolis@VaporSerpent" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            plasma-manager.homeModules.plasma-manager
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/VaporSerpent.nix
          ];
        };

        "mika.zimina@mb-H02L4YFQ6P" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          modules = [
            mac-app-util.homeManagerModules.default
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            ./home-manager/users/mikaz.nix
            ./home-manager/hosts/WorkerBee.nix
          ];
        };

        "drakolis@SilverWing" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          modules = [
            mac-app-util.homeManagerModules.default
            sops-nix.homeManagerModules.sops
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
            ./home-manager/users/drakolis.nix
            ./home-manager/hosts/SilverWing.nix
          ];
        };
      };
    };
}
