# Technology Stack

## Build System

- **Nix Flakes**: Primary build and configuration management system
- **Home Manager**: User environment and dotfiles management
- **nix-darwin**: macOS system configuration (for Darwin hosts)

## Core Technologies

### System Configuration
- **NixOS**: Linux system configuration
- **nix-darwin**: macOS system configuration  
- **Home Manager**: User environment management
- **SOPS**: Secrets management with encryption

### Desktop Environments
- **KDE Plasma**: Full desktop environment with plasma-manager
- **Hyprland**: Wayland compositor
- **Niri**: Scrollable-tiling Wayland compositor
- **Ignis**: Custom Python-based desktop shell (GTK4 + Python)

### Development Tools
- **Neovim**: Primary text editor with Lua configuration
- **VSCode/Zed**: Additional editors with Nix extensions
- **Multiple language support**: Configured for various programming languages

### Key Dependencies
- **nixpkgs**: Package repository (nixos-unstable channel)
- **plasma-manager**: KDE Plasma configuration management
- **niri-flake**: Niri compositor integration
- **ignis**: Custom desktop shell framework
- **sops-nix**: Secrets management integration

## Common Commands

### System Management
```bash
# Rebuild NixOS system configuration
sudo nixos-rebuild switch --flake .#<hostname>

# Rebuild Darwin system configuration  
darwin-rebuild switch --flake .#<hostname>

# Update Home Manager configuration
home-manager switch --flake .#<user>@<hostname>

# Update flake inputs
nix flake update

# Check flake configuration
nix flake check
```

### Development
```bash
# Enter development shell
nix develop

# Build specific output
nix build .#<output>

# Run application from flake
nix run .#<app>
```

### Secrets Management
```bash
# Edit encrypted secrets
sops <secrets-file>

# Update age keys
sops updatekeys <secrets-file>
```

## File Extensions and Languages

- **`.nix`**: Nix configuration files
- **`.py`**: Python (Ignis desktop configuration)
- **`.lua`**: Lua (Neovim configuration)
- **`.scss`**: SASS stylesheets (Ignis theming)
- **`.toml`**: Configuration files (pyproject.toml, etc.)
- **`.yaml/.yml`**: SOPS secrets and configuration files