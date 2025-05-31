{ config, pkgs, ... }:
{
  # [NETW-3200] Disable unused network protocols
  boot.blacklistedKernelModules = [
    "dccp" # Datagram Congestion Control Protocol	-- Obsolete, rarely used
    "sctp" # Stream Control Transmission Protocol	-- Specialized, often unused
    "rds" # Reliable Datagram Sockets	-- Oracle DB-related, niche
    "tipc" # Transparent Inter-Process Communication	-- Cluster comms, often unnecessary
    "n-hdlc" # Non-HDLC (serial comms)	-- Legacy serial protocol
    "ax25" # Amateur X.25 (HAM radio)	-- Niche, amateur radio use
    "netrom" # Amateur NET/ROM	-- Legacy amateur radio
    "x25" # X.25 (old packet-switched network)	-- Deprecated
    "rose" # ROSE (amateur radio networking)	-- Rarely used
    "decnet" # DECnet (Digital Equipment Corp)	-- Legacy, obsolete
    "econet" # Acorn Econet	-- Extremely old, unused
    "af_802154" # IEEE 802.15.4 (Zigbee, LoWPAN)	-- IoT-specific, often unneeded
    "ipx" # Internetwork Packet Exchange (Novell)	-- Legacy, mostly dead
    "appletalk" # AppleTalk (old Mac networking)	-- Deprecated since macOS X
    "psnap" # SubNetwork Access Protocol	-- Obsolete
    "p8023" # IEEE 802.3 (Ethernet LLC)	-- Rarely needed
    "p8022" # IEEE 802.2 (Logical Link Control)	-- Legacy
    "can" # Controller Area Network (automotive)	-- Only needed in embedded/automotive
    "atm" # Asynchronous Transfer Mode	-- Legacy telecom protocol
  ];

  security = {
    protectKernelImage = true; # Prevent kernel image tampering

    sudo = {
      execWheelOnly = true; # Only allow wheel group to run sudo
      extraConfig = ''
        Defaults timestamp_timeout=30
      '';
    };

    lockKernelModules = true; # Prevent loading new kernel modules
    forcePageTableIsolation = true; # Mitigate Meltdown
    virtualisation.flushL1DataCache = "always"; # Mitigate L1TF

    # Core dump prevention
    pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "core";
        value = "0"; # Disable core dumps
      }
    ];

    # [FINT-4350] File integrity monitoring
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

  services = {
    # [LOGG-2146, LOGG-2154] Configure logging
    journald.extraConfig = ''
      Storage=persistent
      SystemMaxUse=1G  # Limit log size
      ForwardToSyslog=yes
      MaxRetentionSec=30day
    '';
  };

  environment.systemPackages = with pkgs; [
    termshark
    nmap
    lynis # Security audit
    vulnix
  ];

  hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket"; # Restrict profiles
}
