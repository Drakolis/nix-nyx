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
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      # This should correspond to the hostname of the machine
      YDdraigGoch = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos.nix
          ./hosts/gaming.nix
          ./hosts/YDdraigGoch/configuration.nix
          ./hosts/YDdraigGoch/hardware-configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "drakolis@YDdraigGoch" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        modules = [ ./home-manager/drakolis.nix ];
      };
    };
  };
}
