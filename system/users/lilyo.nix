{
  pkgs,
  ...
}:
{
  users.users.lilyo = {
    isNormalUser = true;
    description = "Lily Oliveira";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      element-desktop
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ ];
  };
}
