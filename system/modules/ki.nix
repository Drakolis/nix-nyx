{ config, pkgs, lib, ... }:
let cfg = config.drakolis.ki;
in with lib; {

  options = {
    drakolis.ki = {
      enable = mkOption {
        default = false;
        type = with types; bool;
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
      enable = true;
      port = 50000;
      usageCollection = false;

    };

    systemd.services.ollama = {
      description = "Ollama AI server";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "ollama serve";
        Restart = "always";
        # User = "ollama";
        # Group = "ollama";
      };
    };

  };

}
