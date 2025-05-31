{ config, pkgs, lib, ... }:
{
  # [BOOT-5264] Hardening system services
  systemd = {
    services = {
      # Apply hardening to all services
      "*" = {
        # Restrict service capabilities
        serviceConfig = {
          # Isolate services
          PrivateTmp = "yes";
          PrivateDevices = "yes";
          ProtectSystem = "strict";
          ProtectHome = "yes";
          NoNewPrivileges = "yes";
          RestrictSUIDSGID = "yes";
          ProtectKernelTunables = "yes";
          ProtectKernelModules = "yes";
          ProtectControlGroups = "yes";
          LockPersonality = "yes";
          MemoryDenyWriteExecute = "yes";
          RestrictRealtime = "yes";
          RestrictNamespaces = "yes";
          CapabilityBoundingSet = "~CAP_SYS_ADMIN CAP_SYS_PTRACE CAP_SETUID CAP_SETGID CAP_SYS_CHROOT";
        };
      };
    };
  };

  security = {
    protectKernelImage = true; # Prevent kernel image tampering

    # [ACCT-9630, ACCT-9632] Configure audit system with proper rules
    auditd = {
      enable = true;
      extraConfig = ''
        # Basic audit configuration
        log_file = /var/log/audit/audit.log
        log_format = RAW
        log_group = root
        priority_boost = 4
        freq = 20
        num_logs = 5
        disp_qos = lossy
        max_log_file = 8
        max_log_file_action = ROTATE
        space_left = 75
        space_left_action = SYSLOG
        admin_space_left = 50
        admin_space_left_action = SUSPEND
        disk_full_action = SUSPEND
        disk_error_action = SUSPEND
      '';
      # Define basic audit rules
      extraRules = ''
        # Track modifications to authentication mechanisms
        -w /etc/passwd -p wa -k auth
        -w /etc/shadow -p wa -k auth
        -w /etc/group -p wa -k auth
        -w /etc/gshadow -p wa -k auth
        -w /etc/security -p wa -k auth
        -w /etc/pam.d/ -p wa -k auth

        # Monitor command execution
        -a always,exit -F arch=b64 -S execve -k exec

        # Monitor administrative actions
        -a always,exit -F path=/bin/su -F perm=x -F auid>=1000 -F auid!=-1 -k privileged
        -a always,exit -F path=/usr/bin/sudo -F perm=x -F auid>=1000 -F auid!=-1 -k privileged

        # Monitor file access
        -a always,exit -F arch=b64 -S open,openat,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=-1 -k file_access
        -a always,exit -F arch=b64 -S open,openat,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=-1 -k file_access
      '';
    };
    audit.enable = true;

    sudo = {
      execWheelOnly = true; # Only allow wheel group to run sudo
      extraConfig = ''
        Defaults timestamp_timeout=30
        Defaults use_pty
        Defaults logfile="/var/log/sudo.log"
        Defaults lecture=always
        Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
      '';
    };

    lockKernelModules = true; # Prevent loading new kernel modules
    forcePageTableIsolation = true; # Mitigate Meltdown
    virtualisation.flushL1DataCache = "always"; # Mitigate L1TF

    # [AUTH-9230, AUTH-9262, AUTH-9286] Configure PAM and password settings
    pam.services = {
      system-auth = {
        # [AUTH-9230] Configure password hashing rounds
        passwordHashRounds = 65536;

        # [AUTH-9262] PAM module for password strength testing
        pam =
          let
            cracklib = {
              enable = true;
              retry = 3;
              difok = 5;
              minlen = 16; # Increased from 12
              dcredit = -1; # Require at least one digit
              ucredit = -1; # Require at least one uppercase
              ocredit = -1; # Require at least one special character
              lcredit = -1; # Require at least one lowercase
              gecoscheck = true; # Check against GECOS field
              enforce = true; # Enforce password quality
            };
          in
          {
            password.requiredPamModules = [ pkgs.cracklib pkgs.pam_passwdqc ];
            password.passwordQuality = cracklib;
          };

        # [AUTH-9286] Configure password age requirements
        passwordChangeDays = 7;   # Minimum password age (7 days)
        passwordMaxAgeDays = 90;  # Maximum password age (90 days)
      };

      # Apply similar settings to other login services
      login = {
        passwordHashRounds = 65536;
        passwordChangeDays = 7;
        passwordMaxAgeDays = 90;
      };

      passwd = {
        passwordHashRounds = 65536;
        passwordChangeDays = 7;
        passwordMaxAgeDays = 90;
      };
    };

    # Core dump prevention
    pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "core";
        value = "0"; # Disable core dumps
      }
      # Restrict maximum number of user processes
      {
        domain = "*";
        type = "hard";
        item = "nproc";
        value = "2048";
      }
      # Restrict maximum number of open files
      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "4096";
      }
    ];

    # [FINT-4350] File integrity monitoring
    apparmor = {
      enable = true;
      packages = [ pkgs.apparmor-profiles ];
    };

    # [USB-1000] Disable USB storage
    kernel.sysctl = {
      # [KRNL-6000] Kernel hardening with sysctl
      "kernel.kptr_restrict" = 2;                  # Hide kernel pointers
      "kernel.dmesg_restrict" = 1;                 # Restrict dmesg access
      "kernel.perf_event_paranoid" = 3;            # Restrict performance events
      "kernel.kexec_load_disabled" = 1;            # Disable kexec
      "kernel.yama.ptrace_scope" = 1;              # Restrict ptrace
      "kernel.unprivileged_bpf_disabled" = 1;      # Disable unprivileged BPF
      "kernel.unprivileged_userns_clone" = 0;      # Disable unprivileged user namespaces
      "kernel.sysrq" = 0;                          # Disable SysRq key

      # Network protection
      "net.ipv4.conf.all.rp_filter" = 1;           # Enable reverse path filtering
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.accept_redirects" = 0;    # Disable ICMP redirects
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.accept_source_route" = 0; # Disable source routing
      "net.ipv4.conf.default.accept_source_route" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;      # Don't send redirects
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;  # Ignore broadcast pings
      "net.ipv4.tcp_syncookies" = 1;               # Enable SYN cookies
      "net.ipv6.conf.all.accept_redirects" = 0;    # Disable IPv6 redirects
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_ra" = 0;           # Disable router advertisements
      "net.ipv6.conf.default.accept_ra" = 0;

      # [NETW-3200] Disable unused protocols
      "net.core.bpf_jit_harden" = 2;               # Harden BPF JIT compiler
    };
  };

  # [NETW-3200] Disable unused network protocols
  boot.blacklistedKernelModules = [
    "dccp"  # Datagram Congestion Control Protocol
    "sctp"  # Stream Control Transmission Protocol
    "rds"   # Reliable Datagram Sockets
    "tipc"  # Transparent Inter-Process Communication
    "n-hdlc" # Non-HDLC
    "ax25"  # Amateur X.25
    "netrom" # Amateur NET/ROM
    "x25"   # X.25
    "rose"  # ROSE
    "decnet" # DECnet
    "econet" # Acorn Econet
    "af_802154" # IEEE 802.15.4
    "ipx"   # Internetwork Packet Exchange
    "appletalk" # AppleTalk
    "psnap" # SubNetwork Access Protocol
    "p8023"  # IEEE 802.3
    "p8022" # IEEE 802.2
    "can"   # Controller Area Network
    "atm"   # Asynchronous Transfer Mode
    "usb-storage" # [USB-1000] Disable USB storage
  ];

  # [FILE-6310] Separate partitions for /tmp and /var
  fileSystems = {
    "/tmp" = lib.mkIf (config.fileSystems ? "/tmp") {
      options = [ "nodev" "nosuid" "noexec" ];
    };
    "/var" = lib.mkIf (config.fileSystems ? "/var") {
      options = [ "nodev" ];
    };
    "/var/log" = lib.mkIf (config.fileSystems ? "/var/log") {
      options = [ "nodev" "nosuid" "noexec" ];
    };
    "/var/tmp" = lib.mkIf (config.fileSystems ? "/var/tmp") {
      options = [ "nodev" "nosuid" "noexec" ];
    };
  };

  # Login warning banner
  environment.etc."issue".text = ''
    \n (\l), \S Linux Kernel \r \m
    Unauthorized access to this system is prohibited.
    All activity on this system is logged and monitored.
    Unauthorized activities will be reported to the appropriate authorities.
  '';

  # [NAME-4028] DNS configuration
  networking = {
    domain = "local";
    nameservers = [ "1.1.1.1" "9.9.9.9" ]; # Cloudflare and Quad9 DNS
    dhcpcd.extraConfig = ''
      nohook resolv.conf
    '';
    firewall = {
      enable = true;
      allowPing = false;
      logRefusedConnections = true;
      # [FIRE-4513] Regularly analyze iptables rules
      extraStopCommands = ''
        iptables -S | grep -v "^-P" | sort > /var/log/iptables_rules.log
      '';
    };
  };

  # [PRNT-2307] Restrict CUPS access
  services = {
    printing = {
      enable = true;
      browsing = false;
      listenAddresses = [ "localhost:631" ]; # Only listen on localhost
      allowFrom = [ "localhost" ];
      defaultShared = false;
    };

    # [SSH-7408] Harden SSH configuration
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        X11Forwarding = false;
        AllowTcpForwarding = false;  # Changed from YES to NO
        AllowAgentForwarding = false; # Changed from YES to NO
        PermitEmptyPasswords = false;
        MaxAuthTries = 3;            # Changed from 6 to 3
        MaxSessions = 2;             # Changed from 10 to 2
        LoginGraceTime = 30;
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;     # Changed from 3 to 2
        UseDNS = false;              # Changed from YES to NO
        TCPKeepAlive = false;        # Changed from YES to NO
        Compression = false;
        LogLevel = "VERBOSE";        # Changed from INFO to VERBOSE
        StrictModes = true;
        # Using a non-standard port is recommended
        # Port = 2222;               # Uncomment and set your preferred port
        Protocol = 2;
      };
      extraConfig = ''
        AllowGroups wheel
        MaxStartups 2:30:10
        DebianBanner no
      '';
    };

    # [LOGG-2146, LOGG-2154] Configure logging
    opensnitch.enable = true;
    journald = {
      extraConfig = ''
        Storage=persistent
        SystemMaxUse=1G  # Limit log size
        ForwardToSyslog=yes
        MaxRetentionSec=30day
      '';
    };

    # [LOGG-2154] Remote logging
    rsyslogd = {
      enable = true;
      defaultConfig = ''
        # Log all to local files
        *.* -/var/log/syslog
        # Forward all logs to remote log server (uncomment and configure)
        # *.* @logserver.example.com:514
      '';
    };

    # [ACCT-9622, ACCT-9626] Process accounting
    sysstat = {
      enable = true;
      collect.enable = true;
    };
    auditbeat = {
      enable = true;
    };
  };

  # [FINT-4350] File integrity monitoring with AIDE
  environment.systemPackages = with pkgs; [
    termshark
    nmap
    opensnitch-ui
    lynis           # Security audit
    aide            # File integrity monitoring
    rkhunter        # Rootkit detection
    chkrootkit      # Rootkit detection
    vulnix          # [PKGS-7398] NixOS vulnerability scanner
    sysstat         # System statistics
    tiger           # Security auditing
    usbguard        # USB device policy framework
    libpam-pwquality # PAM password quality checking
    fail2ban        # Brute force protection
    auditbeat       # Audit data shipper
  ];

  programs.wireshark.enable = true;

  # [ACCT-9622] Process accounting
  services.acct.enable = true;

  # [AUTH-9284] Manage locked accounts
  users.users = {
    # Example of removing a locked account (uncomment and modify as needed)
    # messagebus = {
    #   uid = lib.mkForce null;
    #   isSystemUser = lib.mkForce false;
    #   group = lib.mkForce "";
    # };
  };

  # [FINT-4350] Setup AIDE file integrity monitoring
  systemd.services.aide = {
    description = "AIDE File Integrity Monitor";
    after = [ "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.aide}/bin/aide --check";
      User = "root";
    };
  };

  systemd.timers.aide = {
    description = "Run AIDE file integrity check daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  # [HRDN-7222] Restrict compiler access to root
  security.wrappers = {
    gcc = {
      source = "${pkgs.gcc}/bin/gcc";
      owner = "root";
      group = "root";
      permissions = "0700";
    };
    g++ = {
      source = "${pkgs.gcc}/bin/g++";
      owner = "root";
      group = "root";
      permissions = "0700";
    };
    cc = {
      source = "${pkgs.gcc}/bin/cc";
      owner = "root";
      group = "root";
      permissions = "0700";
    };
  };

  # Hardware and bluetooth settings
  hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket"; # Restrict profiles
}
