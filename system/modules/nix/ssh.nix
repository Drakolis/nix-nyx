{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.ssh;
in
with lib;
{
  options = {
    drakolis.ssh = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable open ssh server.
        '';
      };
      useMosh = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Use mosh instead of regular ssh.
        '';
      };
    };
  };

  config = {
    services.openssh = {
      enable = cfg.enable;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        X11Forwarding = false;
        AllowTcpForwarding = false;
        AllowAgentForwarding = false;
        PermitEmptyPasswords = false;
        MaxAuthTries = 3;
        MaxSessions = 2;
        LoginGraceTime = 30;
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;
        UseDns = false;
        TCPKeepAlive = false;
        Compression = false;
        LogLevel = "VERBOSE";
        StrictModes = true;
        Protocol = 2;
      };
    };
    # Mobile SSH
    programs.mosh.enable = cfg.useMosh;
  };
}
