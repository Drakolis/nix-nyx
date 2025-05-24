{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.fonts;
  fontSets = lib.types.enum [
    "default"
    "ubuntu"
  ];
in
with lib;
{
  options = {
    drakolis.fonts = {
      fontSet = mkOption {
        default = "default";
        type = fontSets;
        description = ''
          Select the font set to use.
        '';
      };
    };
  };
  config = {
    fonts.packages =
      with pkgs;
      if (cfg.fontSet == "ubuntu") then
        [
          ubuntu-sans
          ubuntu-sans-mono
          nerd-fonts.ubuntu
          nerd-fonts.ubuntu-mono
        ]
        ++ lib.optionals stdenv.hostPlatform.isLinux [
          noto-fonts-emoji
        ]
      else
        [
          noto-fonts
          noto-fonts-extra
          noto-fonts-cjk-sans
          hack-font
          nerd-fonts.hack
        ]
        ++ lib.optionals stdenv.hostPlatform.isLinux [
          noto-fonts-emoji
        ];
  };
}
