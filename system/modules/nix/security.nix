{ config, pkgs, ... }:
{
  security = {
    protectKernelImage = true; # Prevent kernel image tampering
    auditd.enable = true;
    audit.enable = true;

    sudo = {
      execWheelOnly = true; # Only allow wheel group to run sudo
      extraConfig = ''
        Defaults timestamp_timeout=30
      '';
    };

    lockKernelModules = true; # Prevent loading new kernel modules
    forcePageTableIsolation = true; # Mitigate Meltdown
    virtualisation.flushL1DataCache = "always"; # Mitigate L1TF

    # System hardening
    pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "core";
        value = "0"; # Disable core dumps
      }
    ];

    apparmor = {
      enable = true;
      packages = [ pkgs.apparmor-profiles ];
    };
  };

  environment.etc."issue".text = ''
    \n (\l), \S Linux Kernel \r \m
    Unauthorized access to this system is prohibited.
    All activity on this system is logged and monitored.
    Unauthorized activities will be reported to the appropriate authorities.
  '';

  hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket"; # Restrict profiles

  services = {
    opensnitch.enable = true;
    journald.extraConfig = ''
      Storage=persistent
      SystemMaxUse=1G  # Limit log size
    '';
  };

  environment.systemPackages = with pkgs; [
    termshark
    nmap
    opensnitch-ui
    lynis # Security audit
  ];
}
