{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.development;

  languagesMinimalPackages = with pkgs; [
    nodejs
    python3
    go
  ];

  nodeExtendedPackages = with pkgs; [
    yarn
    typescript
    typescript-language-server
    vue-language-server
  ];

  pythonExtendedPackages = with pkgs; [
    python3Packages.pip
    python3Packages.jupyter
    python3Packages.numpy
    python3Packages.pandas
    jetbrains.pycharm-community
  ];

  goExtendedPackages = [ ];

  luaPackages = with pkgs; [
    lua
    lua-language-server
  ];

  rustPackages = with pkgs; [
    rustc
    rustfmt
    cargo
    rust-analyzer
  ];

  javaPackages = with pkgs; [
    jdk
    maven
    gradle
    java-language-server
  ];

  ideaCEPackages = with pkgs; [
    jetbrains.idea-community-bin
  ];

  terraformPackages = with pkgs; [
    terraform
    terraform-ls
  ];

  extraLanguageServersPackages = with pkgs; [
    dockerfile-language-server
    yaml-language-server
    docker-compose-language-service
  ];

  languagePackages =
    languagesMinimalPackages
    ++ lib.optionals cfg.languages.nodeExtended nodeExtendedPackages
    ++ lib.optionals cfg.languages.pythonExtended pythonExtendedPackages
    ++ lib.optionals cfg.languages.goExtended goExtendedPackages
    ++ lib.optionals cfg.languages.lua luaPackages
    ++ lib.optionals cfg.languages.rust rustPackages
    ++ lib.optionals cfg.languages.java javaPackages
    ++ lib.optionals (cfg.languages.java && !cfg.languages.noIdea) ideaCEPackages
    ++ lib.optionals cfg.languages.terraform terraformPackages
    ++ lib.optionals cfg.languages.extraLanguageServers extraLanguageServersPackages;

  zshExtraPlugins = [ "npm" ];
in
with lib;
{
  options = {
    drakolis.development.languages = {
      nodeExtended = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable extra NodeJS packages for this user.
        '';
      };
      pythonExtended = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable extra Python packages for this user.
        '';
      };
      goExtended = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable extra Go packages for this user.
        '';
      };
      lua = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Lua Language for this user.
        '';
      };
      rust = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Rust Language for this user.
        '';
      };
      java = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Java Language for this user.
        '';
      };
      noIdea = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Do not install IDEA CE
        '';
      };
      terraform = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Terraform Language for this user.
        '';
      };
      extraLanguageServers = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable extra language servers for this user.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zsh."oh-my-zsh".plugins = zshExtraPlugins;

    home.packages = languagePackages;
  };
}
