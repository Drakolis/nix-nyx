# Useful Nix commands for the talk

## Nix Store commands

#### `cd /nix/store`

#### `nix-store --optimize`

#### `nix-tree` *

#### `nix-collect-garbage`

#### `nix-collect-garbage -d`

#### `nix-shell -p <package-name>`

## Configuration vs Flakes

### Classic configuration file commands

#### `nix-channel --add https://nixos.org/channels/nixos-unstable nixos`

#### `nix-channel --list`

#### `nixos-rebuild switch`

### Flake commands

#### `nix flake update`

#### `nixos-rebuild switch --flake ~/nix-nyx`

### Package managers (home-manager)

#### `home-manager switch --flake ~/nix-nyx`

#### [Current home-manager configuration options](https://home-manager.dev/manual/unstable/options.xhtml)
