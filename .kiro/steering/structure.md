---
inclusion: always
---

# Project Structure & Organization

## Directory Hierarchy

```
├── flake.nix              # Main flake - defines all system/home configurations
├── flake.lock             # Dependency lockfile - update with `nix flake update`
├── .sops.yaml             # SOPS encryption config - required for secrets
├── system/                # System-level NixOS/Darwin configurations
├── home-manager/          # User environment configurations
└── shared/                 # Shared resources across all configurations
```

## System Configuration (`system/`)

**Entry Points:**
- `nixos.nix` - NixOS base configuration
- `darwin.nix` - macOS base configuration

**Structure:**
- `hosts/<hostname>/` - Per-machine configurations
  - `configuration.nix` - Main host config (REQUIRED)
  - `hardware-configuration.nix` - Hardware settings (REQUIRED for NixOS)
- `modules/nix/` - NixOS-specific modules
- `modules/darwin/` - macOS-specific modules  
- `users/` - System user account definitions

## Home Manager Configuration (`home-manager/`)

**Structure:**
- `hosts/<hostname>.nix` - Per-machine user environment configs
- `users/<username>.nix` - Per-user base configurations
- `modules/` - Modular components:
  - `desktop/` - DE configs (kde, hyprland, niri) + shared components
  - `development/` - Dev tools, languages, IDEs
  - `terminals/` - Terminal emulator configurations
  - `neovim/` - Complete Neovim setup with Lua configs
  - `yazi/` - File manager configuration

## Shared Resources (`shared/`)

- `constants/` - Nix expressions for colors, paths, styling constants
- `images/wallpapers/` - Desktop wallpapers
- `config/` - Application configuration files
- `audio/` - Sound assets

## File Patterns & Conventions

### Required Files
- `default.nix` - Module entry point that imports other files
- `configuration.nix` - Main configuration for hosts
- `hardware-configuration.nix` - Auto-generated hardware config (NixOS only)

### Import Patterns
- Use relative paths from module root
- Platform-specific imports: `lib.optionals stdenv.isLinux [ ./linux-module.nix ]`
- Conditional module loading based on host capabilities

### Naming Rules
- **Hostnames**: Mythological themes (`Joermungandr`, `YDdraigGoch`) or descriptive (`WorkerBee`)
- **Modules**: Lowercase with hyphens (`desktop-environment.nix`)
- **Constants**: camelCase in Nix expressions

## Configuration Dependencies

1. `flake.nix` → defines all outputs (nixosConfigurations, homeConfigurations)
2. System configs → import platform base + host-specific + user definitions
3. Home configs → import user base + host overrides + feature modules
4. Modules → provide reusable functionality with proper option definitions

## AI Assistant Guidelines

- **Always check both system and home-manager** when modifying configurations
- **Maintain platform separation** - use conditional imports for platform-specific code
- **Follow the module hierarchy** - don't bypass the established structure
- **Test configurations** before switching using build commands
- **Use relative imports** from the appropriate module root directory
