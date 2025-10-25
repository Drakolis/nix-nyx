{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.niri-switch.packages.${pkgs.system}.default
    inputs.niri-screen-time.packages.${pkgs.system}.default
  ];
  programs.niriswitcher = {
    enable = false;
    # style = ''
    #   #niriswitcher {
    #     background-color: transparent;
    #   }
    # '';
  };
}
