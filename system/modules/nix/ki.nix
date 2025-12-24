{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.ki;
in
with lib;
{
  options = {
    drakolis.ki = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable coding AI suggestions server.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tabby-agent
      kdePackages.alpaka
    ];

    services.tabby = {
      enable = false;
      port = 50000;
      usageCollection = false;
      model = "TabbyML/Qwen2.5-Coder-0.5B";
    };

    services.ollama = {
      enable = true;
      loadModels = [
        "mistral"
      ];
      openFirewall = true;
    };
  };
}
