{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.development;
in
with lib;
{
  options = {
    drakolis.development = {
      enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Enable development for this user.
        '';
      };
    };
  };

  imports = [
    ./languages.nix
    ./tools.nix
    ./vscode.nix
  ];
}
