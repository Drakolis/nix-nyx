---
inclusion: always
---

# Technology Stack & Development Guidelines

## Core Technologies

### Build System & Package Management
- **Nix Flakes**: Primary build system - all configurations must be flake-compatible
- **nixpkgs**: Use `nixos-unstable` channel for latest packages
- **Home Manager**: Manages user environments - prefer over system-wide package installation
- **SOPS**: Required for all secrets - never commit unencrypted sensitive data

### Platform Support
- **NixOS**: Primary Linux platform with full desktop environment support
- **nix-darwin**: macOS support via Homebrew integration (nix-homebrew)
- **Cross-platform**: Maintain compatibility between Linux and macOS where possible

## Architecture Patterns

### Configuration Structure
- **Modular design**: Split functionality into focused, reusable modules
- **Platform abstraction**: Use conditional imports for platform-specific code
- **Host-specific overrides**: Keep host customizations minimal and well-documented

### Code Style Guidelines
- **Nix expressions**: Use consistent formatting with `nixpkgs-fmt`
- **Module imports**: Always use relative paths from module root
- **Option definitions**: Provide clear descriptions and type annotations
- **Comments**: Document complex logic and platform-specific workarounds

## Development Workflow

### Testing & Validation
```bash
# Always test before switching
nixos-rebuild build --flake .#<hostname>
home-manager build --flake .#<user>@<hostname>

# Check configuration syntax
nix flake check

# Preview changes
nixos-rebuild dry-run --flake .#<hostname>
```

### Configuration Management
```bash
# System configurations
sudo nixos-rebuild switch --flake .#<hostname>
darwin-rebuild switch --flake .#<hostname>

# User environments  
home-manager switch --flake .#<user>@<hostname>

# Maintenance
nix flake update                # Update dependencies
nix-collect-garbage -d         # Clean old generations
```

## Key Components

### Desktop Environments
- **KDE Plasma**: Primary desktop with plasma-manager for declarative config
- **Hyprland**: Wayland compositor for advanced users
- **Niri**: Experimental compositor - expect breaking changes
- **Ignis**: Custom shell components - Python-based widgets

### Development Tools
- **VSCode**: Extensions managed via nix-vscode-extensions
- **Neovim**: Lua-based configuration with plugin management
- **Yazi**: File manager with extensive plugin ecosystem

## Host Reference

### Active Hosts
- **Linux**: `Joermungandr`, `YDdraigGoch`, `Quetzalcoatl`, `WinterDragon`
- **macOS**: `SilverWing`, `WorkerBee`

### Naming Convention
- Use mythological/dragon themes for personal systems
- Descriptive names for work/specialized systems

## Best Practices

### Security
- Use SOPS for all secrets with proper key management
- Avoid hardcoded credentials in configurations
- Regular security updates via `nix flake update`

### Performance
- Minimize system-wide packages - prefer user-level installation
- Use binary caches to reduce build times
- Regular garbage collection to manage disk usage

### Maintenance
- Test configurations before deployment
- Document breaking changes in commit messages
- Keep flake inputs updated but test thoroughly
