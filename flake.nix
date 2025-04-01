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
  };

  outputs =
    { self, nixpkgs, home-manager, plasma-manager, nix-yazi-plugins, ... }: {
      nixosConfigurations = {
        YDdraigGoch = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/nixos.nix
            ./system/gaming.nix
            ./hosts/YDdraigGoch/configuration.nix
            ./hosts/YDdraigGoch/hardware-configuration.nix
          ];
        };
        WinterDragon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/nixos.nix
            ./hosts/WinterDragon/configuration.nix
            ./hosts/WinterDragon/hardware-configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "drakolis@YDdraigGoch" = home-manager.lib.homeManagerConfiguration {
          pkgs =
            nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          modules = [
            nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
            plasma-manager.homeManagerModules.plasma-manager
            ./home-manager/drakolis.nix
          ];
        };
      };
    };
}
