{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.development;

  developmentPackages = with pkgs; [
    tokei # Language usage analyser
  ];

  windsurfPackages = with pkgs; [
    windsurf
  ];

  sqlClientPackages = with pkgs; [
    beekeeper-studio
  ];

  mongoClientPackages = with pkgs; [ mongodb-compass ];

  apiClientPackages = with pkgs; [
    # bruno
    hoppscotch
  ];

  scalewayPackages = with pkgs; [
    scaleway-cli
  ];

  awsPackages = with pkgs; [
    awscli
  ];

  kubernetesPackages = with pkgs; [
    kubectl
  ];

  desiredDevelopmentPackages =
    developmentPackages
    ++ lib.optionals cfg.tools.windsurf windsurfPackages
    ++ lib.optionals cfg.tools.sqlClient sqlClientPackages
    ++ lib.optionals cfg.tools.mongoClient mongoClientPackages
    ++ lib.optionals cfg.tools.apiClient apiClientPackages
    ++ lib.optionals cfg.tools.aws awsPackages
    ++ lib.optionals cfg.tools.kubernetes kubernetesPackages
    ++ lib.optionals cfg.tools.scaleway scalewayPackages;

  zshExtraPlugins = [ ] ++ lib.optionals cfg.tools.scaleway [ "scw" ];
in
with lib;
{
  options = {
    drakolis.development.tools = {
      windsurf = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Windsurf IDE for this user.
        '';
      };
      sqlClient = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable SQL DB client for this user.
        '';
      };
      mongoClient = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable MongoDB client for this user.
        '';
      };
      apiClient = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable API testing tools for this user.
        '';
      };
      scaleway = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Scaleway cli for this user.
        '';
      };
      aws = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable AWS cli for this user.
        '';
      };
      kubernetes = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Kubernetes cli for this user.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zsh."oh-my-zsh".plugins = zshExtraPlugins;

    home.packages = desiredDevelopmentPackages;
  };
}
