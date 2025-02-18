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

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      # This should correspond to the hostname of the machine
      YDdraigGoch = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/YDdraigGoch/configuration.nix
          ./hosts/YDdraigGoch/hardware-configuration.nix
          ./hosts/common.nix
          ./hosts/flatpak.nix
        ];
      };
    };
  };
}
