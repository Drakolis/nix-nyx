{
  config,
  lib,
  ...
}:
let
  cfg = config.drakolis.virtualization;

  archTypes = lib.types.enum [
    "intel"
    "amd"
  ];
in
with lib;
{
  options = {
    drakolis.virtualization = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable virtualization.
        '';
      };
      type = mkOption {
        type = archTypes;
        description = ''
          Choose the vendor - intel or amd.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    # Enable libvirt (which manages KVM/QEMU virtualization)
    virtualisation.libvirtd.enable = true;

    # Load appropriate kernel modules (adjust for AMD or Intel)
    boot.kernelModules = [
      "kvm-${cfg.type}"
    ];

    # Optionally, enable Virt-Manager for a GUI management experience
    programs.virt-manager.enable = true;
  };
}
