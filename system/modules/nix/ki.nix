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
      ollama
      kdePackages.alpaka
    ];

    services.tabby = {
      enable = false;
      port = 50000;
      usageCollection = false;
      acceleration = "rocm";
      model = "TabbyML/Qwen2.5-Coder-0.5B";
    };

    # Define the Ollama server service
    systemd.services.ollama-server = {
      description = "Ollama AI Server";
      serviceConfig = {
        ExecStart = "ollama serve";
        Restart = "always";
      };
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        ollama pull llama2
      '';
    };
  };

}
