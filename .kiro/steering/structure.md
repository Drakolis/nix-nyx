# Project Structure

## Root Level Organization

```
├── flake.nix              # Main flake configuration with inputs/outputs
├── flake.lock             # Locked flake inputs
├── .sops.yaml             # SOPS configuration for secrets
├── NOTES.MD               # Development notes and TODOs
├── system/                # System-level configurations
├── home-manager/          # User environment configurations  
├── shared/                # Shared resources (images, constants, audio)
├── static/                # Static configuration files
```

## System Configuration (`system/`)

```
system/
├── nixos.nix              # Base NixOS configuration
├── darwin.nix             # Base Darwin configuration
├── hosts/                 # Per-machine system configurations
│   ├── Joermungandr/      # Linux desktop
│   ├── YDdraigGoch/       # Linux media/server mini pc
│   ├── Quetzalcoatl/      # Linux laptop
│   ├── WinterDragon/      # Linux laptop
│   ├── SilverWing/        # macOS laptop
│   └── WorkerBee/         # macOS work system
├── modules/               # Reusable system modules
│   ├── nix/               # NixOS-specific modules
│   └── darwin/            # Darwin-specific modules
└── users/                 # System user definitions
```

## Home Manager Configuration (`home-manager/`)

```
home-manager/
├── hosts/                 # Per-machine user configurations
├── modules/               # Reusable user modules
│   ├── default.nix        # Main module imports and options
│   ├── desktop/           # Desktop environment modules
│   │   ├── kde/           # KDE Plasma configuration
│   │   ├── hyprland/      # Hyprland configuration
│   │   ├── niri/          # Niri configuration
│   │   └── shared/        # Shared desktop components
│   ├── development/       # Development tools and languages
│   ├── terminals/         # Terminal emulator configurations
│   ├── nvim/              # Neovim configuration
│   ├── yazi/              # File manager configuration
│   └── security/          # Security and privacy tools
└── users/                 # Per-user configurations
    ├── drakolis.nix       # Primary user
    ├── neinhorn.nix       # Secondary user
    └── mikaz.nix          # Work user
```

## Static Files (`static/`)

```
static/
├── config/                # Application configurations
├── ignis/                 # Custom desktop shell (Python/GTK4)
│   ├── config.py          # Main Ignis configuration
│   ├── bar/               # Desktop bar components
│   ├── launcher/          # Application launcher
│   ├── notifications/     # Notification system
│   ├── scss/              # Styling and themes
│   └── widgets/           # Reusable UI components
└── nvim/                  # Neovim configuration
    ├── init.lua           # Main configuration
    └── lua/               # Lua modules
```

## Shared Resources (`shared/`)

```
shared/
├── constants/             # Nix constants and variables
│   ├── catppuccinMocha.nix # Color scheme definitions
│   ├── commands.nix       # Common command definitions
│   ├── paths.nix          # Path constants
│   └── style.nix          # Style constants
├── images/                # Wallpapers and avatars
└── audio/                 # Sound files
```

## Configuration Patterns

### Module Structure
- Each module typically has a `default.nix` that imports other files
- Options are defined using `lib.mkOption` with proper types
- Modules are imported in parent `default.nix` files

### Host-Specific Configurations
- System hosts in `system/hosts/<hostname>/`
- Home Manager hosts in `home-manager/hosts/<hostname>.nix`
- Hardware configurations separate from logical configurations

### User Configurations
- System users defined in `system/users/`
- Home Manager users in `home-manager/users/`
- User-specific options controlled via module system

### Secrets Management
- Encrypted files managed by SOPS
- Configuration in `.sops.yaml`
- Age keys for encryption/decryption

## Naming Conventions

- **Hostnames**: Mythological creatures/dragons (Joermungandr, YDdraigGoch, etc.)
- **Files**: kebab-case for multi-word files (`hardware-configuration.nix`)
- **Modules**: Descriptive names matching functionality
- **Options**: Namespaced under `drakolis.*` for custom options