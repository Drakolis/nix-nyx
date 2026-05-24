{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.development;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;

  aiToolsPackages =
    with pkgs;
    [
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      kdePackages.alpaka
    ];

  zshExtraPlugins = [ ];
in
with lib;
{
  options = {
    drakolis.development.ai-tools = {
      opencode = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Enable open AI CLI tools for this user.
        '';
      };
      aichat = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Enable open AI CLI tools for this user.
        '';
      };
      opencode-web = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable open AI CLI tools for this user.
        '';
      };
      claudecode = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable proprietery AI CLI tools for this user.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.zsh."oh-my-zsh".plugins = zshExtraPlugins;

    home.packages = aiToolsPackages;

    programs.mcp.enable = true;

    programs.opencode = {
      enable = cfg.ai-tools.opencode;
      enableMcpIntegration = true;
      web.enable = cfg.ai-tools.opencode-web;
      skills = ../../../static/ai/skills;
      web.extraArgs = [
        "--hostname"
        "0.0.0.0"
        "--port"
        "4096"
      ];
    };
    programs.claude-code.enable = cfg.ai-tools.claudecode;

    programs.aichat = {
      enable = cfg.ai-tools.aichat;
      settings = {
        model = "Joermungandr:qwen3.5:9b";
        clients = [
          {
            type = "openai-compatible";
            name = "Scaleway";
            api_base = "https://api.scaleway.ai/v1";
            api_key = "$SCW_SECRET_KEY";
            models = [
              {
                name = "qwen3.5-397b-a17b";
              }
            ];
          }
          {
            type = "openai-compatible";
            name = "Joermungandr";
            api_base = "http://joermungandr:11434/v1";
            models = [
              {
                name = "qwen3.5:9b";
              }
            ];
          }
        ];
      };
    };
  };
}
