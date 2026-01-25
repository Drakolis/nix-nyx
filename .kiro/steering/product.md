---
inclusion: always
---

# Product Overview

This is a personal NixOS/Nix configuration repository managing multiple systems across Linux and macOS platforms using declarative configurations with Nix flakes.

## Architecture Principles

- **Declarative configuration**: All system state defined in Nix expressions
- **Modular design**: Functionality split into reusable modules by purpose
- **Platform abstraction**: Shared logic with platform-specific implementations
- **User-centric**: Configurations organized by user and host combinations

## Key Components

- **System configurations**: Platform-specific base configs (NixOS/Darwin)
- **Home Manager**: User environment and dotfiles management
- **Host-specific configs**: Per-machine customizations and hardware settings
- **Shared resources**: Constants, themes, and assets used across configurations

## Supported Platforms & Environments

- **NixOS**: Primary Linux desktop/server configurations
- **nix-darwin**: macOS system management via Homebrew integration
- **Desktop environments**: KDE Plasma (primary), Hyprland, Niri
- **Development tools**: Comprehensive language support and tooling

## User & Host Management

### Users
- `drakolis`: Primary user across all systems
- `neinhorn`: Partner account for shared systems  
- `mikaz`: Work-specific account (limited to work systems)

### Host Naming Convention
- Mythological/dragon-themed names: `Joermungandr`, `YDdraigGoch`, `Quetzalcoatl`
- Descriptive names: `SilverWing`, `WorkerBee`, `WinterDragon`

## Configuration Guidelines

- **Host configurations**: Always include both `configuration.nix` and `hardware-configuration.nix`
- **Module imports**: Use relative paths and follow the established hierarchy
- **Secrets management**: Use SOPS for sensitive data with `.sops.yaml` configuration
- **Testing**: Build configurations before switching using `nixos-rebuild build`
- **Updates**: Use `nix flake update` to update dependencies, test thoroughly
