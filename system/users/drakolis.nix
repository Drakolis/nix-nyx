{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfgVirtual = config.drakolis.virtualization;

  groupsRegular = [
    "networkmanager"
    "wheel"
    "dialout"
  ];

  groupsVirtual = [
    "libvirtd"
    "qemu-libvirtd"
  ];

  desiredGroups = groupsRegular ++ lib.optionals cfgVirtual.enable groupsVirtual;
in
with lib;
{
  users.users.drakolis = {
    isNormalUser = true;
    description = "Mika Drakolis";
    extraGroups = desiredGroups;
    packages = with pkgs; [
      # protonmail-bridge-gui
      protonvpn-gui
      proton-pass
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIT5ng625FZcgq7XizZGVN2PyJkDAY9QVm8Frk8XCmx/ drakolis@Joermungandr"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrwMCLeZhbuep6a0BHGJe3DLY5KzVQ6ylwvd1Rjv/T/ drakolis@SilverWing"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHpodnqWBxTjXdQcbfReX583wiDy6rsHP0PZsbneHhAh drakolis@Quetzalcoatl"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaNfEcfSnRGQF4k4PWtFhPEME2Ao9QWTyhu/w+/ftgb drakolis@WinterDragon"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUpNcUS4NNyE+yDz/npwhZojZcH17Hybtc95aWbkA4i" # WorkerBee
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpvdctXVRoijDWhYa4BTX33+JfFE0a3+9+tkaB4Szup drakolis@YDdraigGoch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLXFwVqF0t+J5J1pN4To05Ddtmyd7DBbvHTdoXAC8fw drakolis@NanoWyrm"
    ];
  };
}
