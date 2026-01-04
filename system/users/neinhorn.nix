{
  pkgs,
  ...
}:
{
  users.users.neinhorn = {
    isNormalUser = true;
    description = "Lily Oliveira";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      element-desktop
      firefox
      _1password-gui
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ ];
  };
}
